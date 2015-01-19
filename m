From: Dudley Du <dudl@cypress.com>
Subject: RE: [PATCH v18 04/12] input: cyapa: add runtime power management
 interfaces support for the device
Date: Mon, 19 Jan 2015 01:52:20 +0000
Message-ID: <BN1PR06MB07098EF08CBC9493CC132CDD14A0@BN1PR06MB070.namprd06.prod.outlook.com>
References: <1421390055-32760-1-git-send-email-dudl@cypress.com>
 <1421390055-32760-5-git-send-email-dudl@cypress.com>
 <20150118083131.GE15720@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bl2on0141.outbound.protection.outlook.com ([65.55.169.141]:51900
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751179AbbASBwW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Jan 2015 20:52:22 -0500
In-Reply-To: <20150118083131.GE15720@dtor-ws>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "jmmahler@gmail.com" <jmmahler@gmail.com>, "rydberg@euromail.se" <rydberg@euromail.se>, "bleung@google.com" <bleung@google.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: 2015?1?18? 16:32
> To: Dudley Du
> Cc: jmmahler@gmail.com; rydberg@euromail.se; bleung@google.com;
> linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v18 04/12] input: cyapa: add runtime power management
> interfaces support for the device
>
> Hi Dudley,
>
> On Fri, Jan 16, 2015 at 02:34:07PM +0800, Dudley Du wrote:
>
> > +#ifdef CONFIG_PM_RUNTIME
> > +static ssize_t cyapa_show_rt_suspend_scanrate(struct device *dev,
> > +      struct device_attribute *attr,
> > +      char *buf)
>
> The runtime PM was switched to just CONFIG_PM in mainline and
> CONFIG_PM_RUNTIME was dropped. I adjusted the patch accordingly.

Thanks, I will update my knowledge.;)

>
> ...
>
> > -static SIMPLE_DEV_PM_OPS(cyapa_pm_ops, cyapa_suspend, cyapa_resume);
> > +#ifdef CONFIG_PM_RUNTIME
> > +static int cyapa_runtime_suspend(struct device *dev)
>
> I switched both cyapa_runtme_suspend and resume to __maybe_unused and
> dropped #ifdef guards.
>
> Thanks.
>
> --
> Dmitry

This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
