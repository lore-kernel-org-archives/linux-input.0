From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: [PATCH v2] Documented input device properties.
Date: Wed, 11 Jan 2012 16:51:36 +0100
Message-ID: <87hb02w83b.fsf@tac.ki.iif.hu>
References: <1326282991-4715-1-git-send-email-jussi.pakkanen@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:36833 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757584Ab2AKPvk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Jan 2012 10:51:40 -0500
In-Reply-To: <1326282991-4715-1-git-send-email-jussi.pakkanen@canonical.com>
	(Jussi Pakkanen's message of "Wed, 11 Jan 2012 13:56:31 +0200")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jussi Pakkanen <jussi.pakkanen@canonical.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

>> +INPUT_PROP_POINTER:
>> +------------------
>> +There is a one to one mapping between the device coordinates and
>> +screen coordinates.
>
> This is not correct as touchpads fall firmly into INPUT_PROP_POINTER
> land and certainly do not have 1:1 relationship between on-screen and
> device coordinates.
>
>> This property only has meaning for non-touch based
>> +input such as a pen or an eraser. A drawing tablet would have this property
>> +set.
>
> Wacom Bamboo touch can be said is touch based but still is a pointer
> device. Basically pointer device is one that requires use of an
> on-screen pointer to reflect user's movement while with direct devices
> touching object itself serves as a pointer to the user.

So, does the above mean something like this?

device         I_P_POINTER  I_P_DIRECT  1:1
===========================================
tablet           present     present    yes
touchpad         present     missing    no
touchscreen      missing     present    yes
<impossible>     missing     missing    no

Jussi Pakkanen <jussi.pakkanen@canonical.com> writes:

> +INPUT_PROP_POINTER:
> +------------------
> +
> +There does not exist a one to one mapping between the device
> +coordinates and screen coordinates.

If I understood Dmitry right, the existence of a 1:1 mapping has nothing
to do with a device being I_P_POINTER: the presence of this property
means that an on-screen pointer is required to reflect the user's
movement.  (In practice, non direct devices probably always require a
pointer, or maybe I just lack imagination.)

> This property only has meaning for non-touch based input such as a pen
> or an eraser.

And what's its meaning then?  Sorry, maybe it's just me, but I don't
understand such sentences.  In my understanding, a device either carries
a property or not; the meaning of a given property is always the same,
and it's the very role of the documentation to define these meanings.

> +INPUT_PROP_DIRECT:
> +------------------
> +
> +The device coordinates can be directly mapped to screen coordinates

Cool.

> +(i.e. the opposite of INPUT_PROP_POINTER)

Not cool, according to my interpretation of Dmitry's previous review:
see above.

> This property only has meaning for touch-based input.

See my other paragraph above.

Jussi, please don't take this personal!  I'm no expert of this, and I'm
not a native English speaker.  Still I think documentation should be
clear even for such dummies like me, that's why I chimed in.  Hopefully
it isn't considered bikeshedding.
-- 
Thanks,
Feri.
