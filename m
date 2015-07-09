From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH v2] HID: Wacom: Delete unnecessary checks before the
 function call "input_free_device"
Date: Thu, 9 Jul 2015 14:28:53 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507091428290.10183@pobox.suse.cz>
References: <5307CAA2.8060406@users.sourceforge.net> <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6> <530A086E.8010901@users.sourceforge.net> <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6> <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6> <530B5FB6.6010207@users.sourceforge.net> <alpine.DEB.2.10.1402241710370.2074@hadrien> <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <5479D93E.3040407@users.sourceforge.net> <559E0FCF.8000908@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <559E0FCF.8000908@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-input@vger.kernel.org

On Thu, 9 Jul 2015, SF Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 9 Jul 2015 08:00:10 +0200
> 
> The input_free_device() function tests whether its argument is NULL and
> then returns immediately. Thus the test around the call is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

This is really on a "is it worth it?" borderline, but anyway ... applied 
to for-4.3/upstream.

Thanks,

-- 
Jiri Kosina
SUSE Labs
