From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: weird hidraw behaviour
Date: Tue, 1 Oct 2013 15:43:26 +0300
Message-ID: <20131001124326.GZ28875@intel.com>
References: <20130924085606.GI28875@intel.com>
 <F1F6C959961EA744BBD5B8EEF8B8FEA16DDD19DD16@BGMAIL02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26836 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751211Ab3JAMiB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Oct 2013 08:38:01 -0400
Content-Disposition: inline
In-Reply-To: <F1F6C959961EA744BBD5B8EEF8B8FEA16DDD19DD16@BGMAIL02.nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manoj Chourasia <mchourasia@nvidia.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

On Tue, Oct 01, 2013 at 05:13:16PM +0530, Manoj Chourasia wrote:
> Can you please try the attached patch and see if it fixes this issue?

Yes, that patch fixes the issue for me, thanks!

It introduces following warning, though:

drivers/hid/hidraw.c: In function =E2=80=98drop_ref=E2=80=99:
drivers/hid/hidraw.c:320:5: warning: suggest explicit braces to avoid a=
mbiguous =E2=80=98else=E2=80=99 [-Wparentheses]
  if (!hidraw->open)
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
