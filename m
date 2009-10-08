From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH 5/6] haptic: Samsung SoCs PWM controlled haptic support
Date: Thu, 8 Oct 2009 23:58:37 +0530
Message-ID: <5d5443650910081128l58f45148m87735185a0094c31@mail.gmail.com>
References: <20091007061822.GA7602@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759233AbZJHS3R@vger.kernel.org>
In-Reply-To: <20091007061822.GA7602@july>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Bill Gatliff <bgat@billgatliff.com>, ben-linux@fluff.org
List-Id: linux-input@vger.kernel.org

Adding Bill Gatliff.

Hi Kyungmin,

Most of the driver looks fine. I have only one generic comment, but
not for this driver:

- Someone should really work on getting PWM framework (may be the one
written by Bill Gatliff) into the kernel, because
  if we don't do this and if new PWM controller provides it's own APIs
then we can't leverage the chips using them, like the
  case here for ISA1000 and ISA1200. These chips are using the pwm
APIs exported by Samsung PWM controller, but it would
  be painful to integrate other PWM controller if that has slightly
little different API due to its nature.

  So, it would be better to get one generic PWM framework mainline in
the kernel.

> +static int __devexit samsung_pwm_haptic_remove(struct platform_devic=
e *pdev)
> +{
> + =A0 =A0 =A0 struct samsung_pwm_haptic *haptic =3D platform_get_drvd=
ata(pdev);
> +
> + =A0 =A0 =A0 samsung_pwm_haptic_set(&haptic->cdev, HAPTIC_OFF);
> + =A0 =A0 =A0 del_timer_sync(&haptic->timer);

cancel_work_sync ?


--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
