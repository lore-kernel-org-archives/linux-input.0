From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input - mt: Fix input_mt_get_slot_by_key
Date: Thu, 23 Apr 2015 09:49:18 -0700
Message-ID: <CAKdAkRROn=tCuSDmCqsugPAFBsTa5jEZsOEoTBCAFUrheM2X8Q@mail.gmail.com>
References: <1427741655-4142-1-git-send-email-benjamin.tissoires@redhat.com>
	<20150406163349.GD36770@dtor-ws>
	<alpine.LNX.2.00.1504071517260.30181@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1504071517260.30181@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Apr 7, 2015 at 6:17 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Mon, 6 Apr 2015, Dmitry Torokhov wrote:
>
>> > With https://git.kernel.org/cgit/linux/kernel/git/jikos/hid.git/commit/?h=for-4.1/wacom&id=9a1c001298fd567c0f0776ab54ab9965eeb9019f
>> > in Jiri's tree, scheduled for 4.1, this patch should not break any existing
>> > driver. I'd like us to stage it somewhere so that it doesn't get forgotten.
>> >
>> > Henrik's previous concerns were that input_mt_sync_frame() may not be called
>> > by a driver using input_mt_get_slot_by_key(), and now, no driver should be in
>> > this case.
>>
>> I'm OK with it going through Juri's tree.
>>
>> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Perfect, thanks. I have now queued it in for-4.1/upstream.

Actually, thinking about it some more, I do not think this patch is
needed. It should be perfectly fine to replace the tracking ID in a
slot to denote a new contact. From
Documentation/input/multi-touch-protocol.txt

"Creation, replacement and destruction of contacts is achieved by
modifying the ABS_MT_TRACKING_ID of the associated slot.  A
non-negative tracking id is interpreted as a contact, and the value -1
denotes an unused slot.  A tracking id not previously present is
considered new, and a tracking id no longer present is considered
removed."

If some userspace is confused with missing -1 tracking ID for that
slot, that userspace should be fixed.

Thanks.

-- 
Dmitry
