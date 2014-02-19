From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: ff-core effect id handling in case of a failed effect upload
Date: Wed, 19 Feb 2014 12:42:25 +0100
Message-ID: <CADbOyBRX8Zd=WyXpgWo8Kkg5HkAJHjSA0KCiJD_36PLiSKAQJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f179.google.com ([209.85.220.179]:33101 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606AbaBSLm0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Feb 2014 06:42:26 -0500
Received: by mail-vc0-f179.google.com with SMTP id lh14so238995vcb.38
        for <linux-input@vger.kernel.org>; Wed, 19 Feb 2014 03:42:25 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: linux-input@vger.kernel.org, wine-devel@winehq.org

Hi,


In the process of reviewing the Wine DInput translation layer, I
noticed an inconvenience (in the ff-core implementation?) that can
possibly lead to confusing problems to application developers (not
only for Wine), in short:
If a new (id==-1) effect was uploaded (look at
ff-core.c::input_ff_upload(...)) that failed (e.g. returning EINVAL),
ff-core will have assigned a positive number to the effect id. This
can be confusing because the dev->ff->effects[] array will not contain
an element at the index of that new effect id.

Here is a more elaborated description/discussion:
- This is a bug that is either the responsibility of the Linux kernel,
or of Wine (and possibly other applications that do the same thing as
described below):
    It is caused by the following situation:
        When uploading an effect, the specific kernel device driver
may return an error,
        e.g. EINVAL for example when a periodic's effect period is set to zero.
        This error will then be returned by "ioctl(*(This->fd),
EVIOCSFF, &This->effect)".
        With or without error, one can find out that
/drivers/input/ff-core.c:input_ff_upload(...) is called,
        which will set effect->id >= 0, if it was set to -1 (=> new
effect created) by the user.

        But in case of an error:
        - Assume effect->id was set to -1 by the user:
            The error is reported by ff->upload(...) at
/drivers/input/ff-core.c:167,
            the effect->id will also be set >= 0 (*).
            The offending effect will not be saved in the
ff->effects[] array (***).
        - Assume effect->id was set >= 0 by the user (and
ff->effects[effect->id] is a valid existing effect):
            The error is reported by ff->upload(...) at
/drivers/input/ff-core.c:167,
            the effect->id will remain unchanged (**).
            The offending effect will not overwrite the
ff->effects[effect->id] element (****).

        Is this (see *, **, *** and ****) desired behaviour?
        - If yes:
            Change the following in Wine's dinput/effect_linuxinput.c:90 :
                if (ioctl(*(This->fd), EVIOCSFF, &This->effect) == -1) {
            to :
                int effectId_old = This->effect.id;
                if (ioctl(*(This->fd), EVIOCSFF, &This->effect) == -1) {
                    This->effect.id = effectId_old;
        - If no for *:
            Kernel code /drivers/input/ff-core.c:input_ff_upload(...)
has to be patched to revert "effect->id" back to its original value
set by the user,
            which is only needed when the initial (by user) value of
"effect->id" was equal to -1.
        - If no for **** (or maybe also ***):
            ff->effects[effect->id] could be replaced by an 'empty'
effect (however this can get complex because the effect's type has to
remain unchanged)
            This would be a change in the kernel code
/drivers/input/ff-core.c:input_ff_upload(...).
        - If no for **:
            I don't really know. Discussion is needed.

        - In my opinion, **, *** and **** are desired behaviour, while
* should leave the effect->id at -1.
            In that case, Wine's dinput implementation does not have
to be patched, and the kernel code only should apply a minor patch.


Best regards,

Elias
