From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Add new i2c-based input mouse driver into input subsystem for
 Cypress trackpad devices. (issue6626009)
Date: Thu, 3 Mar 2011 23:59:22 -0800
Message-ID: <20110304075921.GA4323@core.coreip.homeip.net>
References: <bcaec52c66a51e1eda049da36252@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35554 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759046Ab1CDH7a (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Mar 2011 02:59:30 -0500
Content-Disposition: inline
In-Reply-To: <bcaec52c66a51e1eda049da36252@google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dudl@cypress.com, rubini@ipvvis.unipv.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, olofj@google.com, micahc@google.com, chromium-os-reviews@chromium.org, vb+kernel@g

Hi Dudley,

On Fri, Mar 04, 2011 at 07:49:18AM +0000, dudl@cypress.com wrote:
> Reviewers: rubini_ipvvis.unipv.it, dmitry.torokhov_gmail.com,
> linux-input_vger.kernel.org, linux-kernel_vger.kernel.org, olofj_g,
> Micah C, dudl,
> 
> Description:
> Add new i2c-based input mouse driver into input subsystem for
> Cypress trackpad
> devices.
> 
> Through this new added driver,
> Cypress i2c-based trackpad devices will be supported in Linux based system
> which are developed based on Cypress self-designed PSOC chipset.
> This driver reads trackpad data using i2c interfaces and report cursor
> moving data and gesture combined keys to input subsystem.
> 
> 
> Change-Id: I108ad1505f3d34ab24658921a772e937940a1b88
> Signed-off-by: Du, Dudley <dudl@cypress.com>
> 
> BUG=None
> TEST=Work fine on ARM tegra2 saeboard and kaen platfrom
> 
> Please review this at http://codereview.chromium.org/6626009/
> 

Please post your patches in unified diff format on the input mainling
list (linux-input@vger.kernel.org, and please also CC me) - this is
common (and only) way for mainline patch submission.

Thank you.

-- 
Dmitry
