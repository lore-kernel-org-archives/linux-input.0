From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH v4] input/keyboard: new OpenCores Keyboard Controller
	driver
Date: Tue, 15 Sep 2009 23:57:32 -0400
Message-ID: <8bd0f97a0909152057v2049371aif4118691d56165c8@mail.gmail.com>
References: <20090915055224.GD1132@core.coreip.homeip.net>
	<1253066440-25555-1-git-send-email-vapier@gentoo.org> <20090916034555.GA2756@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753206AbZIPD5u@vger.kernel.org>
In-Reply-To: <20090916034555.GA2756@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Herrero <jherrero@hvsistemas.es>, Bryan Wu <cooloney@kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Sep 15, 2009 at 23:45, Dmitry Torokhov wrote:
> On Tue, Sep 15, 2009 at 10:00:40PM -0400, Mike Frysinger wrote:
>> +
>> +static int __devexit opencores_kbd_remove(struct platform_device *p=
dev)
>> +{
>> + =C2=A0 =C2=A0 struct opencores_kbd *opencores_kbd =3D platform_get=
_drvdata(pdev);
>> +
>> + =C2=A0 =C2=A0 free_irq(opencores_kbd->irq, opencores_kbd);
>> +
>> + =C2=A0 =C2=A0 input_unregister_device(opencores_kbd->input);
>> + =C2=A0 =C2=A0 kfree(opencores_kbd);
>
> You need to do iounmap and free the memory region here as well.

ugh, i remembered i would have to do this while writing the initial
code, but forgot while double checking the different error paths
-mike
