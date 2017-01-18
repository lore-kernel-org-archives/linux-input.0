From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: touchscreen: add driver for Zeitec ZET6223
Date: Wed, 18 Jan 2017 14:49:46 -0800
Message-ID: <20170118224946.GC11881@dtor-ws>
References: <20161223163214.7716-1-jelle@vdwaa.nl>
 <20170114191425.GA31309@dtor-ws>
 <20170118205712.GA5333@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35338 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750717AbdARWtu (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 18 Jan 2017 17:49:50 -0500
Content-Disposition: inline
In-Reply-To: <20170118205712.GA5333@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jelle van der Waa <jelle@vdwaa.nl>
Cc: Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org

On Wed, Jan 18, 2017 at 09:57:14PM +0100, Jelle van der Waa wrote:
> On 01/14/17 at 11:14am, Dmitry Torokhov wrote:
> > > +
> > > +static const struct of_device_id zet6223_of_match[] = {
> > > +	{ .compatible = "zeitec", "zet6223" },
> > 
> > The compatible should be "zeitec,zet6223", what you have here is
> > equivalent of:
> > 
> > 	{ .compatible = "zeitec", .data = "zet6223" },
> 
> Ah that was silly, thanks :)
> 
> > I also have been looking at you previosu submission and had some draft
> > changes. I reconciled them in the patch below, if it still works for you
> > then I'll fold everything together and apply. Please let me know.
> 
> I'll find some time to test the patch below, I've one small suggestion
> to the patch below.
> 
> > +	ts->fingernum = buf[15] & 0x7F;
> > +	if (ts->fingernum > ZET6223_MAX_FINGERS) {
> > +		dev_warn(&ts->client->dev,
> > +			 "touchpanel reports %d fingers, limiting to %d\n",
> > +			 ts->fingernum, ZET6223_MAX_FINGERS);
> > +		ts->fingernum = 16;
> 
> Maybe use ZET6223_MAX_FINGERS?

Makes sense, I'll change before applying.

Thanks.

-- 
Dmitry
