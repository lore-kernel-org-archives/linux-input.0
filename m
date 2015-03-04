From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: wacom: ask for a in-prox report when it was missed
Date: Wed, 4 Mar 2015 11:00:37 -0500
Message-ID: <20150304160037.GA25087@mail.corp.redhat.com>
References: <1425403228-19841-1-git-send-email-benjamin.tissoires@redhat.com>
 <54F66042.60107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54F66042.60107@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>
List-Id: linux-input@vger.kernel.org

On Mar 03 2015 or thereabouts, Jason Gerecke wrote:
> On 3/3/2015 9:20 AM, Benjamin Tissoires wrote:
> >If noone listens to the input device when a tool comes in proximity,
> >the tablet does not send the in-prox event when a client becomes available.
> >That means that no events will be sent until the tool is taken out of
> >proximity.
> >
> >In this situation, ask for the report WACOM_REPORT_INTUOSREAD which will
> >read the corresponding feature and generate an in-prox event.
> >
> >We don't schedule this read while we are in an IO interrupt because we
> >know that usbhid will do it asynchronously. If this is triggered by uhid
> >then this is obviously a client side bug :)
> >
> >Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Ping and I were both a little confused by this patch. Our first impression
> was that this wouldn't accomplish anything since the driver would see events
> from the tablet regardless of if a client were connected or not. Testing
> proved us wrong though, with the events clearly going to that great
> /dev/null in the sky. Is this behavior different from the USB and HID
> subsystems? IIRC, the prox code didn't use to behave like this...

I made further tests this morning, and I found out that one of my
patches adds a more consistent (though a defect) behavior:
b905811a49bcd ("HID: usbhid: prevent unwanted events to be sent when
re-opening")

Without this patch applied, and with an Intuos Pro, I can reproduce the
bug, but sometimes it doesn't trigger. If I let the tool down on the
sensor long enough when no client is listening, then the in-prox event
is not sent to the kernel. But if the time between the landing of the
tool and the open of the device node is small enough, the in-prox event
is seen.

So I installed a v3.16 kernel and can reproduce the same behavior
observed previously.

My analysis is:
- the HID subsystem uses PM in the same way wacom_sys.c used to do in
  v3.16
- v3.16 showed the bugs too, but we never noticed it
- with b905811a49bcd, the bug is more obvious and reliable given that we
  drain the first few milliseconds when we open the device (so we miss
  the in-prox event if it was sent)
- I can not reproduce the second bug mentioned in
  http://lists.freedesktop.org/archives/wayland-devel/2015-March/020361.html
  so it must be device dependent

I think we still need to fetch the current tool in case we receive
events while no in-prox event has been seen. This gives a more reliable
behavior and may also help in some other corner cases.

I think we also still need to keep b905811a49bcd because it should
prevent the second problem Peter observed. The out-of-prox event should
disappear with b905811a49bcd, but we need this patch to actually retrieve
the current tool given that we might have dropped the in-prox event.
 
> Under the assumption that USB events are indeed being dropped until a client
> is connected, then this patch looks fairly reasonable. It doesn't, however,
> seem to work reliably across tablets. An Intuos Pro reacted as I'd expect
> (with the patch in place, already-in-prox tools actually send events once
> e.g. evemu-record is run) but didn't seem to do anything for an Intuos5 or
> Intuos3 (nothing comes through evemu-record until I removed the tool from
> prox and then put it back in).

I'll test on such devices tomorrow. The spec says that the report ID 5
was there since Intuos 2 at least, so I guess there must be a way to
retrieve the info correctly on old devices too.

Cheers,
Benjamin
