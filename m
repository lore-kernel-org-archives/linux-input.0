From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: touchscreen: edt_ft5x06 - change msleep to
 usleep_range for small msecs
Date: Wed, 4 Jan 2017 10:58:46 -0800
Message-ID: <20170104185846.GB40341@dtor-ws>
References: <1480358514-2894-1-git-send-email-a.mathur@samsung.com>
 <CAOXgUe1MULGQZJ=pNsSKrvVcCFptVn5b2Qafjao1_xrxVYn0JQ@mail.gmail.com>
 <d95fa514-6e3f-1eb3-8204-60a7d7df494d@kernelconcepts.de>
 <CADYu309AZ_pj_ssVqPV+sXjW8fqMKTXwL_EoTBgLg2K1Ci614Q@mail.gmail.com>
 <708bb254-2830-63c6-f8c8-38fba0b8f988@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <708bb254-2830-63c6-f8c8-38fba0b8f988@kernelconcepts.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Simon Budig <simon.budig@kernelconcepts.de>
Cc: Aniroop Mathur <aniroop.mathur@gmail.com>, Aniroop Mathur <a.mathur@samsung.com>, daniel.wagener@kernelconcepts.de, LW@karo-electronics.de, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, SAMUEL SEQUEIRA <s.samuel@samsung.com>, Rahul Mahale <r.mahale@samsung.com>
List-Id: linux-input@vger.kernel.org

On Wed, Jan 04, 2017 at 07:19:56PM +0100, Simon Budig wrote:
> On 03/12/16 19:17, Aniroop Mathur wrote:
> > Since here we are using msleep(1) which is worse as it sleeps for
> > minimum two jiffies so 20 ms on HZ=100 system and we are doing here
> > 100 retries if register reading fails. So as you can deduce usleep_range
> > will serve better here.
> > Explained originally here why to not use msleep for 1-20ms:
> > http://lkml.org/lkml/2007/8/3/250
> 
> Acked-by: Simon Budig <simon.budig@kernelconcepts.de>

Applied, thank you.

> 
> Bye,
>         Simon
> -- 
>      kernel concepts GmbH                 Simon Budig
>      Sieghuetter Hauptweg 48              simon.budig@kernelconcepts.de
>      D-57072 Siegen                       +49-271-771091-17
>      http://www.kernelconcepts.de/
>      HR Siegen, HR B 9613; Geschäftsführer: Nils Faerber, Ole Reinhardt
> 
> 




-- 
Dmitry
