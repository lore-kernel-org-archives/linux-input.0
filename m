From: Dudley Du <dudl@cypress.com>
Subject: RE: [PATCH v1 3/7] input: cyapa: add proximity function support for
 gen5 and gen6 modules
Date: Tue, 21 Jul 2015 01:43:13 +0000
Message-ID: <CY1PR06MB1817C8EF17F1C4099509B025D1840@CY1PR06MB1817.namprd06.prod.outlook.com>
References: <1434358897-24668-1-git-send-email-dudl@cypress.com>
 <1434358897-24668-4-git-send-email-dudl@cypress.com>
 <20150721000658.GD15528@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bl2on0114.outbound.protection.outlook.com ([65.55.169.114]:43417
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754709AbbGUB5w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jul 2015 21:57:52 -0400
In-Reply-To: <20150721000658.GD15528@dtor-ws>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "rydberg@euromail.se" <rydberg@euromail.se>, "bleung@google.com" <bleung@google.com>, "jmmahler@gmail.com" <jmmahler@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Dmitry,

Yes, It cannot report the distance per-contact.
Thanks for the update.

Thanks,
Dudley

> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: 2015?7?21? 8:07
> To: Dudley Du
> Cc: mark.rutland@arm.com; robh+dt@kernel.org; rydberg@euromail.se;
> bleung@google.com; jmmahler@gmail.com; devicetree@vger.kernel.org;
> linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v1 3/7] input: cyapa: add proximity function support for gen5
> and gen6 modules
>
> Hi Dudley,
>
> On Mon, Jun 15, 2015 at 05:01:33PM +0800, Dudley Du wrote:
> >
> > +static void cyapa_pip_report_proximity(struct cyapa *cyapa,
> > +const struct cyapa_pip_report_data *report_data)
> > +{
> > +struct input_dev *input = cyapa->input;
> > +u8 distance = report_data->report_head[PIP_PROXIMITY_DISTANCE_OFFSET]
> &
> > +PIP_PROXIMITY_DISTANCE_MASK;
> > +
> > +input_report_abs(input, ABS_MT_DISTANCE, distance);
> > +input_sync(input);
>
> It looks like the distance reported by the hardware is not per-contact
> (i.e. it can not tell that we had 2 fingers on surface and the 2nd one
> was lifted and is now hovering over the surface), so we should be using
> ABS_DISTANCE, not ABS_MT_DISTANCE.
>
> I can adjust it here, no need to resend.
>
> Thanks.
>
> --
> Dmitry

This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
