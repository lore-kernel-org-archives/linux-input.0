From: simon@mungewell.org
Subject: Re: [PATCH v4] HID: hid-lg: Allow for custom device-specific
 properties to be stored in private drv data
Date: Sun, 1 Apr 2012 21:46:33 -0400
Message-ID: <04cae81f4bc46c65625e24eda03e0949.squirrel@mungewell.org>
References: <4193443.YXckiBU47J@qosmio-x300>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:39948 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805Ab2DBBqf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 Apr 2012 21:46:35 -0400
In-Reply-To: <4193443.YXckiBU47J@qosmio-x300>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?=22Michal_Mal=FD=22?= <madcatxster@gmail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, simon@mungewell.org

Hi all,
Looks good to me, built and tested working with a G27.
Simon

Signed-off-by: simon@mungewell.org

> Hi,
>
> I (hopefully) sorted out the mess. This patch only adds support for
> custom device-specific properties which can now be stored as
> private driver data and read/saved using hid_get/set_drvdata().
>
> Signed-off-by: Michal Mal=FD <madcatxster@gmail.com>
>


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
