From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] hid-saitek: Quirk for Saitek R.A.T.7 works with
 R.A.T.9 too
Date: Wed, 5 Nov 2014 15:15:59 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1411051514430.29198@pobox.suse.cz>
References: <CAEP-KKshiXPfDhHPE7uatU70wfiOM-xMbFS2+6VxBbFM-LMfjw@mail.gmail.com> <5458256A.5030404@braincalibration.de> <47D536B5-26CC-4088-B321-30DABDD06A02@gmail.com> <40478FF3-907F-4894-95AA-E09CB4BAA087@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52063 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753996AbaKEOQA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 5 Nov 2014 09:16:00 -0500
In-Reply-To: <40478FF3-907F-4894-95AA-E09CB4BAA087@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ville Aakko <ville.aakko@gmail.com>
Cc: Harald Brinkmann <hbrinkmann@braincalibration.de>, linux-input@vger.kernel.org

On Tue, 4 Nov 2014, Ville Aakko wrote:

> From: Ville Aakko <ville.aakko@gmail.com>
> 
> I have tested HID quirk for Saitek R.A.T.7 with my R.A.T. 9. It works 
> fine for me. Attached patch makes the necessary changes to use the quirk 
> on the R.A.T.9 too, and necessary Kconfig changes too.
> 
> I have stylized the Kconfig option name to include Mad Catz in the 
> option name, as (at least some of) the devices are marketed under Mad 
> Catz brand.
> 
> Signed-off-by: Ville Aakko <ville.aakko@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
