From: Andrew Lutomirski <luto@mit.edu>
Subject: Re: [RFC PATCH] thinkpad-acpi: Improve hardware volume controls
Date: Thu, 12 May 2011 10:50:54 -0400
Message-ID: <BANLkTikX7mMu2me6+O1e-Ub=Cbzerd=J3Q@mail.gmail.com>
References: <bf402af225e7005f052a8ccf92962efa48cbe703.1304979290.git.luto@mit.edu>
 <20110512134827.GA26159@srcf.ucam.org> <BANLkTimmrM4HMATSbsYzz6kh=e9hrfAZmg@mail.gmail.com>
 <20110512143912.GA28141@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43482 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716Ab1ELOvO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 May 2011 10:51:14 -0400
In-Reply-To: <20110512143912.GA28141@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, Dmitry Torokhov <dtor@mail.ru>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org

[Hi, Dmitry -- there's an input layer question in here for you]

On Thu, May 12, 2011 at 10:39 AM, Matthew Garrett <mjg59@srcf.ucam.org>=
 wrote:
> On Thu, May 12, 2011 at 10:24:10AM -0400, Andrew Lutomirski wrote:
>> On Thu, May 12, 2011 at 9:48 AM, Matthew Garrett <mjg59@srcf.ucam.or=
g> wrote:
>> > It looks like SAUM was introduced with the *61 machines, and it's
>> > identical from then on.
>>
>> I wonder the machines with SAUM are the same as the machines on whic=
h
>> pressing mute generates an i8042 keystroke instead of an HKEY. =A0If=
 so,
>> it looks like there's some code (or at least comments) in
>> thinkpad_acpi that mention doing the right thing when the HKEY mute
>> event in generated (e.g. the driver won't send KEY_MUTE to the input
>> layer), so something like my patch along with removing the _OSI(Linu=
x)
>> hack for the newer models might make everything work right.
>
> I think so. The machines we have in the OSI blacklist all appear to h=
ave
> the SAUM method, so I think we can take your patch and drop the
> blacklist. Good work!
>
>> Still, someone who has an older laptop should test it, because all I
>> can do is pretend I carefully inspected all the possible code paths.
>
> I can't see any way this would cause problems, except in the case whe=
re
> the method exists but doesn't do anything. I'd be surprised if that's=
 a
> real problem.
>
>> (Even if it works, don't apply this patch for 2.6.40 as it stands
>> because the ALSA change notification on KEY_MUTE is crap and should =
at
>> least ignore key release events.)
>
> Are you working with the ALSA people on that?

I don't think I need help from ALSA.  I just need to stop telling ALSA
that the volume changes twice every time that mute is pressed.  I'll
send v3 out in the next day or two with the fix.

I do, however, have a question for the input people.  Dmitry: Lenovo
makes laptops which are kind enough to tell us that the volume changed
by sending a keystroke over the atkbd-based keyboard.  (wtf!)  I've
modified the thinkpad-acpi driver to register an input handler to
catch those events coming from the keyboard and send them to ALSA
where they belong.  But if there's a keyboard grab, it won't work.
Would you accept a patch to the input layer to allow filters (or maybe
just filters that specifically request it) to run even if there's a
grab?

Without a change to the input layer, if someone grabs the keyboard
then the volume controls will start getting screwed up.  If X grabs
the keyboard it's even worse because pulseaudio will start getting
extra confused and preventing that is the whole point of this patch.

(Yes, it's gross, but the way around it I can see would be to inject a
custom ACPI method, and that still might not be enough to prevent
userspace from seeing a keystroke that it's really not supposed to
see.  And IMHO custom ACPI methods are even worse than input filters.)

--Andy
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
