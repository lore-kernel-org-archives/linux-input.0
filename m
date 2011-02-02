From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2] altera_ps2: Add devicetree support
Date: Wed, 2 Feb 2011 08:39:59 -0700
Message-ID: <20110202153959.GD20275@angua.secretlab.ca>
References: <20110117220415.GB17963@angua.secretlab.ca>
 <1295848693-28472-1-git-send-email-thomas@wytron.com.tw>
 <20110202043121.GF29148@angua.secretlab.ca>
 <4D4944AA.5040900@wytron.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49216 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754404Ab1BBPkD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Feb 2011 10:40:03 -0500
Content-Disposition: inline
In-Reply-To: <4D4944AA.5040900@wytron.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Chou <thomas@wytron.com.tw>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, nios2-dev@sopc.et.ntust.edu.tw, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Walter Goossens <waltergoossens@home.nl>

On Wed, Feb 02, 2011 at 07:48:58PM +0800, Thomas Chou wrote:
> On 02/02/2011 12:31 PM, Grant Likely wrote:
> >>+static const struct of_device_id altera_ps2_match[] = {
> >>+	{ .compatible = "altr,ps2-1.0", },
> >
> >I thought I had seen 'altera' instead of an abbreviation being used in
> >a previous patch.  I don't care much whether 'altr' or 'altera' is
> >used, but I'd like to know that there is consensus from the Altera
> >users so that all the drivers use the same prefix.
> >
> 
> We had discussed on nios2-dev mailing list, and decided to use
> 'altr' as Walter suggested that it saves space.

Is altr the stock ticker symbol?  The convention is to either use the
stock ticker in all uppercase (although the uppercase bit hasn't been
consistently applied), or to use the full name in lowercase.

g.

