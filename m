From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: power_supply: Change ownership from driver to core
Date: Mon, 23 Mar 2015 19:38:12 +0300
Message-ID: <20150323163812.GL10964@mwanda>
References: <20150323145433.GA1609@mwanda>
 <1427124108.30970.1.camel@AMDC1943>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:38923 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485AbbCWQiI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Mar 2015 12:38:08 -0400
Content-Disposition: inline
In-Reply-To: <1427124108.30970.1.camel@AMDC1943>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-input@vger.kernel.org

On Mon, Mar 23, 2015 at 04:21:48PM +0100, Krzysztof Kozlowski wrote:
> On pon, 2015-03-23 at 17:54 +0300, Dan Carpenter wrote:
> > Hello Krzysztof Kozlowski,
> > 
> > The patch 297d716f6260: "power_supply: Change ownership from driver
> > to core" from Mar 12, 2015, leads to the following static checker
> > warning:
> > 
> > 	drivers/hid/hid-input.c:457 hidinput_setup_battery()
> > 	error: potential NULL dereference 'dev->battery'.
> > 
> 
> Yes, indeed. I'll fix it.
> 
> I suppose Smatch detected this so I wonder why it does not print this
> warning in my configuration (I tried v0.5.0-2916-gbdbeaee0221e and
> v0.5.0-3008-g08de8666209d

That check in the released code buggy is buggy so it doesn't print many
warnings.  When I fixed it, then it prints warnings which look like
real bugs but are false positives.  I'm debating if I should just delete
the check.

Also I was just about to email about this one.

        drivers/power/charger-manager.c:1775 charger_manager_probe()
        error: 'cm->charger_psy' dereferencing possible ERR_PTR()

drivers/power/charger-manager.c
  1770  
  1771          cm->charger_psy = power_supply_register(NULL, &cm->charger_psy_desc,
  1772                                                  &psy_cfg);
  1773          if (IS_ERR(cm->charger_psy)) {
  1774                  dev_err(&pdev->dev, "Cannot register charger-manager with name \"%s\"\n",
  1775                          cm->charger_psy->desc->name);
                                ^^^^^^^^^^^^^^^
  1776                  return PTR_ERR(cm->charger_psy);
  1777          }
  1778  

regards,
dan carpenter
