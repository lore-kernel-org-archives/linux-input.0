From: Leon Romanovsky <leon@leon.nu>
Subject: Re: [alsa-devel] [PATCH] ASoC: wm8962: Convert to devm_input_allocate_device()
Date: Mon, 29 Apr 2013 20:47:37 +0300
Message-ID: <CALq1K=KGrDJZa_w_ZVdriptpiKsWvwYDcx3aV3oVXMyTxMjcqg@mail.gmail.com>
References: <1356009506-4766-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CALq1K=+sJUZ++_sMkU1Sg9+aE-HpF1tnfPHGCEJ789hj19Yp9A@mail.gmail.com>
 <20130425125234.GV5019@opensource.wolfsonmicro.com> <CALq1K=+ViDvsCZDR5KndX-T1Dt6tghPjiP7F6wm+npYOw2DE1A@mail.gmail.com>
 <20130428094745.GA5877@sirena.org.uk> <CALq1K=+=J9oPGvbrXuhS=Bgqj+viC5EAkTHKkNuHxBadExpXdA@mail.gmail.com>
 <20130429101959.GE5019@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ve0-f172.google.com ([209.85.128.172]:64473 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758018Ab3D2RsA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Apr 2013 13:48:00 -0400
Received: by mail-ve0-f172.google.com with SMTP id db10so3312721veb.3
        for <linux-input@vger.kernel.org>; Mon, 29 Apr 2013 10:47:59 -0700 (PDT)
In-Reply-To: <20130429101959.GE5019@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, patches <patches@opensource.wolfsonmicro.com>, linux-input@vger.kernel.org

On Mon, Apr 29, 2013 at 1:19 PM, Mark Brown <broonie@kernel.org> wrote:
> On Sun, Apr 28, 2013 at 09:32:18PM +0300, Leon Romanovsky wrote:
>
>> I think the reason of our misunderstanding is due to the name of
>> input_free_device call. From the code, it is device destroy function,
>> and the freeing itself done as an error handling of
>> input_register_device
>> (http://lxr.free-electrons.com/source/drivers/input/input.c#L2114).
>
>> How do you think we need to proceed? Do I need to send patches with
>> explicit call to input_free_device function?
>
> I really think the input API needs to be looked at here, this is all way
> too error prone.  Calling input_free_device() on something allocated
> using devm_ looks like an error itself...
In general, I agree with you, but I think we both agree that the
current patch is not working as expected.
The problem is that you allocated device with devm_ and later at the
code you tried to register it, but failed. In this case no one will
call to devres_destroy, because it is done at unregister stage only.

I see two possible solutions:
1. short one - fix your patches
2. long one - add input_free_device code into input_register_device
call (http://lxr.free-electrons.com/source/drivers/input/input.c#L2114).


--
Leon Romanovsky | Independent Linux Consultant
        www.leon.nu | leon@leon.nu
