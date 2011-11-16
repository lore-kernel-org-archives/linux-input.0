From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: HID: Dead ./debug/hid/xxx/events
Date: Wed, 16 Nov 2011 15:23:50 -0600
Message-ID: <CAGzDe_ak_xzjJkpQcNwwgL+pu94qfhAixjS=9TF3679cpcPFpw@mail.gmail.com>
References: <20111116095030.GC3335@slate>
	<CAN+gG=F2aFTkhUVp4Sf8p-PdAj5ft1eotuWbnP=WaYAugA8tVw@mail.gmail.com>
	<20111116102514.GA3831@slate>
	<CAGzDe_bdyvOnMJb12gQN9wPSn_dk-g_HxgkEP-x_3DRtB+gP1g@mail.gmail.com>
	<20111116145518.GA7080@slate>
	<20111116154049.GA8444@slate>
	<CAGzDe_ahR9pVkZa8BQkfCq2zeVCojkX=t6WBcQYkrv3z91fb+Q@mail.gmail.com>
	<4EC3EC63.4020700@gmail.com>
	<20111116204759.GA2153@slate>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:35087 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506Ab1KPVXv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 16:23:51 -0500
Received: by eye27 with SMTP id 27so975743eye.19
        for <linux-input@vger.kernel.org>; Wed, 16 Nov 2011 13:23:50 -0800 (PST)
In-Reply-To: <20111116204759.GA2153@slate>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cedric Sodhi <manday@gmx.net>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org, linuxwacom-devel@lists.sourceforge.net

One update on my side.  I was looking at hid-multitouch.c from
Dmitri's next branch and didn't see that ALWAYS_VALID.  So I thought
it was a typo and manually mapping your "18" value to
VALID_IS_INRANGE; which we were previously setting it to.  Thats why I
mentioned I thought you were setting to same quirks.

Thanks for diff.  Often a diff is worth a thousand words.

OK, now back to your email.  I'm confused about your logs.  The URL
points to the tar file with multiple logs and the evtest_twofinger.log
inside it is the one I was talking about having issues.

Now you've attached a new evtest_twofinger.log and its values look
good.  So your saying this new log is from a version based on the
diff?

If so, I'll chalk it up to some debug issue and sounds like
ALWAYS_VALID is indeed the key to this.

Chris

On Wed, Nov 16, 2011 at 2:48 PM, Cedric Sodhi <manday@gmx.net> wrote:
> Dear Benjamin,
>
> I applied your patch tp 3.2-jikos (uname shows 3.1, though). The
> diff to jikos' original is now [attached].
>
> Chris says the output of evtest still signifies problems with
> multitouch:
>
>> > http://ompldr.org/iYmIzYw
>>
>> Cedric, can you send these logs to Benjamin for ideas? =A0The HID ev=
ents
>> look good but the evtest log for 2 fingers is not. =A0The two touche=
s
>> are fighting each other. =A0That "-1" value is interrupted as each
>> finger is being lifted in between each new X/Y report.
>>
>> Also, can you send me and Benjamin the source code diff of what your
>> testing against kernel tree?
>>
>> The behavior in your evtest log looks like what would happen if your
>> setting the MT_QUIRK_NOT_SEEN_MEANS_UP. =A0Since your HW only sends =
1
>> fingers worth of data per packet, you do not want that quirk.
>>
>> I'll still hold off on xf86-input-wacom issues until the events comi=
ng
>> are sane. =A0Your current events will cause xf86-input-wacom to do a=
ll
>> kinds of weird stuff thats not worth effort to weed threw.
>>
>> Chris
>
> These logs in that tarfile were created while still manually adding t=
he
> ID via your sysfs interface. You find yet another evtest log for
> two-finger touch attached.
>
> Cedric
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
