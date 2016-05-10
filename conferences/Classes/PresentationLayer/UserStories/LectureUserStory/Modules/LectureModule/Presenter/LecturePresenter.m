// Copyright (c) 2016 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "LecturePresenter.h"
#import "LectureViewInput.h"
#import "LectureInteractorInput.h"
#import "LectureRouterInput.h"
#import "LecturePresenterStateStorage.h"
#import "LecturePlainObject.h"
#import "SpeakerPlainObject.h"

@implementation LecturePresenter

#pragma mark - LectureModuleInput

- (void)configureCurrentModuleWithLectureObjectId:(NSString *)objectId {
    self.stateStorage.lectureObjectId = objectId;
}

#pragma mark - LectureViewOutput

- (void)setupView {
    LecturePlainObject *lecture = [self.interactor obtainLectureWithObjectId:self.stateStorage.lectureObjectId];
    SpeakerPlainObject *speaker = lecture.speakers.firstObject;
    self.stateStorage.speakerObjectId = speaker.objectId;
    
    [self.view configureViewWithLecture:lecture];
}

- (void)didTapTableViewHeader {
    [self.router openSpeakerInfoModuleWithSpeakerObjectId:self.stateStorage.speakerObjectId];
}

- (void)didTapShareButton {
    LecturePlainObject *lecture = [self.interactor obtainLectureWithObjectId:self.stateStorage.lectureObjectId];
    NSArray *activitiyItems = [self.interactor obtainActivityItemsForLecture:lecture];
    
    [self.router openShareModuleWithActivityItems:activitiyItems];
}

@end