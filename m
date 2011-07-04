From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5] input: Initial support for Kionix KXTJ9 accelerometer
Date: Mon, 4 Jul 2011 07:25:45 -0700
Message-ID: <20110704142545.GB8144@core.coreip.homeip.net>
References: <1309288348-30735-1-git-send-email-chris.hudson.comp.eng@gmail.com>
 <4E0B1D0D.5000204@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49040 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab1GEEgd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 00:36:33 -0400
Received: by iwn6 with SMTP id 6so4900484iwn.19
        for <linux-input@vger.kernel.org>; Mon, 04 Jul 2011 21:36:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E0B1D0D.5000204@cam.ac.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: chris.hudson.comp.eng@gmail.com, linux-input@vger.kernel.org, Chris Hudson <chudson@kionix.com>

On Wed, Jun 29, 2011 at 01:39:41PM +0100, Jonathan Cameron wrote:
> On 06/28/11 20:12, chris.hudson.comp.eng@gmail.com wrote:
> > +static int kxtj9_input_open(struct input_dev *input)
> > +{
> > +	struct kxtj9_data *tj9 = input_get_drvdata(input);
> > +
> > +	return kxtj9_enable(tj9);
> return kxtj9_enable(input_get_drvdata(input));

Actually I prefer limiting use of void pointers. If kxtj9_enable()
changes to take something other than "struct kxtj9_data *" then original
will issue a warning while the proposed form will happily accept it.

Thanks.

-- 
Dmitry
