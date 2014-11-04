From: Harald Brinkmann <hbrinkmann@braincalibration.de>
Subject: Re: PATCH: Quirk (hid-saitek.c) for Saitek R.A.T.7 works with R.A.T.9
 too
Date: Tue, 04 Nov 2014 02:01:30 +0100
Message-ID: <5458256A.5030404@braincalibration.de>
References: <CAEP-KKshiXPfDhHPE7uatU70wfiOM-xMbFS2+6VxBbFM-LMfjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from static.59.56.47.78.clients.your-server.de ([78.47.56.59]:53826
	"EHLO www.braincalibration.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751584AbaKDBRd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 3 Nov 2014 20:17:33 -0500
In-Reply-To: <CAEP-KKshiXPfDhHPE7uatU70wfiOM-xMbFS2+6VxBbFM-LMfjw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ville Aakko <ville.aakko@gmail.com>, jkosina@suse.cz
Cc: linux-input@vger.kernel.org, trivial@kernel.org

On 11/02/2014 03:37 PM, Ville Aakko wrote:
> p.s. I have never submitted patches, I apologize if I have done something in a 
> wrong way! Should I have added / updated the description in the comments?

I think you should update linux/drivers/hid/Kconfig and add the R.A.T.9
to the list of supported devices in the HID_SAITEK section.

-- 
Cheers,
Harald
