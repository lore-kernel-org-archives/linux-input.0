From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Evdev - Avoid data loss when clock type is changed
Date: Tue, 4 Aug 2015 17:19:32 -0700
Message-ID: <20150805001932.GA18957@dtor-ws>
References: <1438381732-29681-1-git-send-email-aniroop.mathur@gmail.com>
 <20150804165049.GA37185@dtor-ws>
 <CADYu30_f+PW00+vFSe6Dp6Gh-b0nmkHYr8JG5SdM8vbhj=-fCA@mail.gmail.com>
 <20150804232208.GF37185@dtor-ws>
 <CADYu30-8AFW2Aax7XmWm4xyH5pQhtHHhcxBVp7CGyWWrXPC1cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36743 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242AbbHEATf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Aug 2015 20:19:35 -0400
Received: by pacgq8 with SMTP id gq8so20326155pac.3
        for <linux-input@vger.kernel.org>; Tue, 04 Aug 2015 17:19:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CADYu30-8AFW2Aax7XmWm4xyH5pQhtHHhcxBVp7CGyWWrXPC1cA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <aniroop.mathur@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, a.mathur@samsung.com

On Wed, Aug 05, 2015 at 05:37:57AM +0530, Aniroop Mathur wrote:
> On Wed, Aug 5, 2015 at 4:52 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Wed, Aug 05, 2015 at 03:29:06AM +0530, Aniroop Mathur wrote:
> >> Hello Mr. Torokhov,
> >>
> >> On Tue, Aug 4, 2015 at 10:20 PM, Dmitry Torokhov
> >> <dmitry.torokhov@gmail.com> wrote:
> >> > Hi Aniroop,
> >> >
> >> > On Sat, Aug 01, 2015 at 03:58:52AM +0530, Aniroop Mathur wrote:
> >> >> When clock type is changed, previously stored data is flushed
> >> >> and therfore does not reach to upper layer or application.
> >> >> Data is critically important along with the timestamp.
> >> >> So to avoid data loss and send correct timestamp as well,
> >> >> lets not flush data upon clock type change and
> >> >> to send correct timestamp, store only monotonic timestamp during write
> >> >> and change monotonic clock time to desired clock time during read.
> >> >
> >> > I wonder if this matters that much. The only time where this change would make
> >> > difference is when you have a reader thread and then a controlling
> >> > thread changing clocks. Then you probably do not want to lose events,
> >> > but you also would not know for given event what kind of timestamp it
> >> > uses.
> >> >
> >>
> >> For this case, I would like to throw some insight.
> >> We could lose events and not know what kind of timestamp it uses but we can
> >> know if timestamp is proper or not. If frequency of events are very high and
> >> clock type is changed in between, it is possible that new timestamp is less
> >> than old timestamp. Although it is a correct timestamp as per clock type but
> >> for application it would mean that there is some problem with event timestamp
> >> because it is ideally impossible that timestamp of new event is less than
> >> previous event timestamp. This can happen if events are flushed or not.
> >> But I think losing events is a bigger issue than an incorrect timestamp.
> >
> > Why? I can see that you would not want to lose keyboard events for
> > example, but for them you do not really care about timestamps, but for
> > other devices, like absolute touchpads and touchscreens, dropped events
> > can and do happen (imagine you for some reason get a spike in CPU load
> > and your reader does not schedule quickly enough to drain the event
> > queue).
> >
> 
> If user touches the screen and no response comes then it does not seem okay
> as user desires to receive response for every input. So how come losing events
> is okay ?

Because the device will continue generating events while user is
maintaining the touch.

But regardless, the "normal" application behavior:

1. Open /dev/input/eventX
2. Select desired clock type for the life of application
3. Retrieve the current device state (optional step)
4. Read event
5. If encountered SYN_DROPPED goto step 3.
6. Act upon event
7. Goto step 4.


In this case it does not really matter that we flush the queue on step 2
as we lose the events that were sent before step 1 and in any case you
recover by fetching the device state if needed.

> As i have seen in my device, even when cpu load is completely okay,
> scheduling gets delayed "sometimes" resulting in delay of event reporting.
> For faster devices like "sensors", losing or dropping events seems to
> be critical
> because it impacts device performance. If someone is playing game using sensors
> and sensor events gets lost in between then it results in unexpected response.

The sensor will continue generating data. The only time when losing
events is really important is for "slow" devices like keyboards that
generate single event or a pair of events in response to user action.

> 
> 
> >>
> >> > On the other hand I expect that your application changes clock type the
> >> > very first thing after opening the event device. In this case the
> >> > flushing queue does not matter: you are losing events that happened
> >> > before you opened the device, so it does not really matter if you lose a
> >> > few more in the beginning.
> >> >
> >> > I guess I need better understanding of your use case.
> >> >
> >>
> >> Before explaining my use case, I would like to tell you about application which
> >> checks timestamp strictly.
> >> Application Name - CTS Verifier.
> >> This is the application developed by Google to check functionality of android
> >> device. It is mandatory for every android device in the world to pass all test
> >> cases, otherwise device cannot be released in market. In the sensor module,
> >> this application performs verifications like EventOrderVerification,
> >> EventGapVerification, EventTimestampSynchronizationVerification, etc.
> >> EventTimestampSynchronizationVerification verifies that the timestamp of the
> >> event is synchronized with SystemClock.elapsedRealtimeNanos(), based on a given
> >> threshold.
> >> Ref Link:
> >> https://source.android.com/compatibility/overview.html
> >> http://androidxref.com/5.1.1_r6/xref/cts/tests/tests/hardware/src/android/
> >> hardware/cts/helpers/sensorverification/EventTimestampSynchronizationVerification.java
> >
> > OK.
> >
> >>
> >> My Use Case:
> >> Like cts application, My application checks for sensor events and provide
> >> suggestions to correct it at run time. It checks sensor working from
> >> "kernel side" by opening up the event device and enable the sensor so that
> >> driver starts reporting events. It reads the events and checks if there are any
> >> event time synchronization errors, event gap errors, etc are there or
> >> not just like cts.
> >> Event time synchronization error is checked using api
> >> SystemClock.elapsedRealtimeNanos(). Event time synchronization error occurs
> >> because event timestamp and timestamp received using
> >> SystemClock.elapsedRealtimeNanos() does not match.
> >> If event time synchronization error occurs, the application changes the clock
> >> type and then check if error is still occuring. Now when clock type is changed,
> >> event time synchronization error is removed but event gap error occurs
> >> because events are lost.
> >> Application working dummy example:
> >> 1. data_x1, data_y1, time1... TimeSync - NOT OK, EventGap - OK
> >> 2. data_x1, data_y1, time1... TimeSync - NOT OK, EventGap - OK
> >> Application decides to change clock
> >> 3. data_x1, data_y1, time1... TimeSync - OK, EventGap - NOT OK
> >> 4. data_x1, data_y1, time1... TimeSync - OK, EventGap - NOT OK
> >
> > Now just teach your application that seeing a gap upon clock change is
> > OK and call it a day.
> >
> 
> However, it is possible to get correct timestamp without event gap.
> So there will be no issue of either event gap or timestamp.
> Why it is not possible to follow this approach of fixing both things ?

I explained my reason below: with the change as proposed it becomes
impossible for an application to reliably detect clock type change in
case where thread changing the clock type is different from the thread
reading the data.

> 
> >>
> >> So, both test cases could not be checked together and thats how I came up with
> >> the idea that it is better not to flush the events upon clock change.
> >>
> >> Similar use case for complete checking of driver, hal, framework where we use
> >> original cts application and our application.
> >> Similar use case for sensor simulator.
> >>
> >> Like in sensor domain, there can be more use cases in other domains which other
> >> domain team members must be aware of.
> >>
> >> Apart from above, I have always read and learnt that kernel code should be
> >> generic and should work fine for all application uses upon kernel upgrade.
> >> I guess if events are lost in previous kernel version, them it should not be
> >> lost in new version.
> >
> > That is not entirely true. We improve behavior of the kernel all the
> > time and in this particular case I consider the behavior an improvement,
> > because it allows application to recognize old vs new timestamps
> > explicitly even in case when thread consuming the events is separate
> > from the thread that is changing clock type.
> >
> > Thanks.
> >
> > --
> > Dmitry

-- 
Dmitry
