From: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1] Support Elan Touchscreen eKTF product.
Date: Mon, 22 Oct 2012 19:12:22 +0200
Message-ID: <CAN+gG=HyzcRnp_Bd=WRq2Hn_5QKCVCjvFjXCvO1xXbAcyBOJfQ@mail.gmail.com>
References: <1350424679-20725-1-git-send-email-scott.liu@emc.com.tw>
	<87hapnnp5t.fsf@emc.com.tw>
	<20121022160705.GC13791@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121022160705.GC13791-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jian-Jhong Ding <jj_ding-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>, Scott Liu <scott.liu-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jesse <jesse-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>, Vincent Wang <vincent.wang-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>, Paul <paul.liang-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, Oct 22, 2012 at 6:07 PM, Dmitry Torokhov
<dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Mon, Oct 22, 2012 at 11:47:42AM +0800, Jian-Jhong Ding wrote:
>> Scott Liu <scott.liu-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org> writes:
>> > +
>> > +struct mt_device {
>> > +   struct mt_slot curdata; /* placeholder of incoming data */
>> > +   __u8 num_received;      /* how many contacts we received */
>> > +   __u8 num_expected;      /* expected last contact index */
>> > +   __u8 maxcontacts;
>> > +   bool curvalid;          /* is the current contact valid? */
>> > +   struct mt_slot *slots;
>> > +};
>>
>> With Benjamin's i2c-hid implimentation, is it possible to make
>> hid-multitouch not depend on USBHID and reuse it to drive this device?

We can already use hid-multitouch with hid over I2C devices (I'm
testing my i2c devices with this module).
But it's true that hid-multitouch depends on usbhid, and I the funny
think is that I was removing this dependency today.
The fact is that currently, i2c devices do not segfault with
hid-multitouch  because win8 devices do not require anymore to set
some feature at plug.

>
> Exactly. Before looking any further - is this the same part that Tom Lin
> posted a driver for earlier this summer?

I'm not Elan, and I can not be sure, but judging from the "hello
packets" and the other commands, I doubt this device is an I2C over
HID one.

Anyway, reusing hid-multitouch for this specific case seams to be a
little bit difficult. You would have first to provide a fake report
descriptor (or inject commands as if you were hid-core) and then, you
would have to reformat the incoming data into valid win7 (or 8)
packets. Judging by the functions elan_touch_parse_fid,
elan_touch_parse_wid and elants_parse_xy, the data seem to be mixed
(all the finger ids at the beginning, and not one per touch), so it is
definitively needed to recreate a valid HID packet.

So I'm not surprised with the duplicated code. However, Henrik did a
big job in kernel 3.7 to factorize mt code, and some part of the
duplication can be achieve with these functions (look at
input_mt_sync_frame and input_mt_get_slot_by_key for example).

Cheers,
Benjamin

>
> Thanks.
>
> --
> Dmitry
