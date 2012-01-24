From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Subject: Re: [PATCH v1] Input: tegra-kbc - enable key interrupt for wakeup
Date: Tue, 24 Jan 2012 10:54:54 +0530
Message-ID: <CANQgH-beKYUpRigRRgzDmWajoSd7ZT_k_EaWkUax2XzqHKg8og@mail.gmail.com>
References: <1326925981-14723-1-git-send-email-riyer@nvidia.com>
	<4F17AE75.6000605@ti.com>
	<1FC56210173BB445BD77F608D6FB8D034F401D296F@HQMAIL03.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:41780 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750713Ab2AXFY4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Jan 2012 00:24:56 -0500
In-Reply-To: <1FC56210173BB445BD77F608D6FB8D034F401D296F@HQMAIL03.nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rakesh Iyer <riyer@nvidia.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, Stephen Warren <swarren@nvidia.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Rakesh,

On Thu, Jan 19, 2012 at 11:51 PM, Rakesh Iyer <riyer@nvidia.com> wrote:
>> =A0 =A0 =A0 if (device_may_wakeup(&pdev->dev)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 disable_irq_wake(kbc->irq);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_kbc_setup_wakekeys(kbc, false);
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* We will use fifo interrupts for key det=
ection. */
>> + =A0 =A0 =A0 =A0 =A0 =A0 tegra_kbc_set_keypress_interrupt(kbc, fals=
e);
> Why do yo disable on resume why not have it enabled always?
>
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Restore the resident time of continuo=
us polling mode. */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(kbc->cp_to_wkup_dly, kbc->mmio + =
KBC_TO_CNT_0);
>
> For the relevant discussion, Tegra KBC provides the following interru=
pts -
> a) The keypress interrupt which is generated as soon as a key is pres=
sed,
> =A0 =A0 =A0before matrix scanning begins.
> b) FIFO interrupt which is generated when actual keys are decoded fro=
m the matrix,
> =A0 =A0 and put into the FIFO.
>
> During normal operation the keypress interrupt is not useful as we ha=
ve to wait for the
> keys to make it into the FIFO before reporting it to the higher layer=
s.
>
> Since we have turned off scanning(in the following commit) we cannot =
use the FIFO interrupt
> during the resume, so we rely on the keypress interrupt and generate =
the wakeup key.
>
> Commit that turned off scanning
>
> =A0 =A0Input: tegra-kbc - fix wakeup from suspend
>
> =A0 =A0For wakeup to be reliable, kbc needs to be in interrupt mode b=
efore suspend.

Does it need to be disabled at resume?

> =A0 =A0Created common routine to control the FIFO interrupt.
> =A0 =A0Added synchronization to ensure orderly suspend.
>
>
> Regards
> Rakesh
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
