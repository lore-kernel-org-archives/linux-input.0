From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: Re: [PATCH 11/11] misc: Add slave driver for bma085 pressure sensor
Date: Fri, 01 Jul 2011 12:35:24 +0200
Message-ID: <4E0DA2EC.1000407@iis.fraunhofer.de>
References: <1309486707-1658-1-git-send-email-nroyer@invensense.com> <1309486707-1658-11-git-send-email-nroyer@invensense.com> <4E0D8DC7.6060108@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay01-haj2.antispameurope.com ([83.246.65.51]:58347 "EHLO
	relay01-haj2.antispameurope.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750835Ab1GAKpG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 1 Jul 2011 06:45:06 -0400
In-Reply-To: <4E0D8DC7.6060108@cam.ac.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Nathan Royer <nroyer@invensense.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Jiri Kosina <jkosina@suse.cz>, Alan Cox <alan@linux.intel.com>, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On 01.07.2011 11:05, Jonathan Cameron wrote:
> Hang on, so your motion processing unit takes in a pressure sensor?
> Interesting....
>
> Manuel, am I imagining things or did you have a driver for one of the=
se?
Yes, indeed we have one for bmp085. I have to update it for the latest=20
API, but these are things I'm going to do during the next 2 month.

Regards,

--=20
Manuel Stahl
=46raunhofer-Institut IIS
Leistungsoptimierte Systeme

Nordostpark 93
D90411 N=FCrnberg
Telefon  +49 (0)911/58061-6419
=46ax      +49 (0)911/58061-6398
E-Mail   manuel.stahl@iis.fraunhofer.de

http://www.iis.fraunhofer.de
http://www.smart-power.fraunhofer.de

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
