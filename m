Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019988;
	b=g66FCKf/aT5OnUUmZwEzafctTogP0pXvqMPoxAaf0kx3krnru+czvT77HTvaJE5TV+ir
	 HDiexVP5EajcTkz9MyB9+GTcYwrFyL6PbGb0VQuuZLMTzBfa5O/t81CRB4/ZhdueZMVij
	 sA2+p1wUHySi/vVu6G4VQNj6pTmEECaUtAaQ07sqvQAUSwBrpIutk6Wyjb0ti5xhcOs9N
	 spe+VilFQaSEQoSgFs47sHt+GRi7Ie/Ygos3CcnQgP2t3VWzgkF1xAQ4Q81NfVbzK4SUE
	 BLU/hHAGPeE0Vqgcl21WXYaS4BYErx7sRyfiLWQ8d1D6tI6MIsQyoaJQbaNL7yhDNWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019988;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=Ry+Wk1vhXn0Z7fHJXctDib73O0NuQz3oFiNxRaWAcWI=;
	b=CFShLp1oZqMMsBWAQqVXvT/NJ3dQ9jJgwyGxmZJ1EKjNBpD451ne5hOzIwWc9OpphT9P
	 Oq7y/8RjfeuqJPRusFSTK/7gP3NjCVosjkpMyuShoBNZppc2XbifxpJs0qGYHCqQdCoZK
	 eyxIDc9J7AC1BYgbwkr0XIwzeNDUxVPiEpgsAEQkWQdc16JdWIfRLy8KBIuyHB3sxdJ9Q
	 qZiSwRswD6d1evw7cmadBJTa8x/6qKmAboCAbmEW3/Y0WBYU1Vf30qpKI38ccP2ZwTcaB
	 v9V8Oc+hrd5P3A48KL+UkCqzfshtRayV3uR/PwrNIl7x59zx1pxGPzwDZDphhzLciSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jZvH3GTl;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BD4606A31D;
	Mon, 26 Oct 2026 13:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19BD4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jZvH3GTl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793019988; x=1824555988;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Rw8pw5zvvX9JOX1l1ZII7MKCfa5Y2Lkq7dXbUZfDkv4=;
  b=jZvH3GTljC3fPq29Wi7QxGUhGGzcMf+i3WGC2vqbBONBhHMSCiZHBtKi
   xxn42FbMJknQK6WYXyM/Qsl8cpmR7Stc9oEhkOL/asnQcvbo/tumKw6rf
   B6wLnw9NTjnvGqjhpdhoafO45c5zGHMpdXEBSP5OkEowIkyhdrs8WTKWm
   OjzFLqXvlfPQq1z7Sjpq08cBAyhQCVRbbsY4no38RTNzSulUBiKPFQVB9
   yQw2YotQy797dsjHmLVrB12Xpvre/B993V3qBd/VDaeiVN/6U2v250NqJ
   6xW3+nn/sORSsepBwnsE4Zq+KNbMEBLL0W+E780+fgbZ9sJnSxD5mJiP/
   w==;
X-CSE-ConnectionGUID: PAyvnzA8TmK/k+CJElXxPw==
X-CSE-MsgGUID: qtBB1oIMRhma6xCLh7f61A==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1586702"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1586702"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 06:06:27 -0700
X-CSE-ConnectionGUID: YjeaQhXYRwqDjQTlusdygw==
X-CSE-MsgGUID: vCSZsGwnQAOC69peClh3Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="6017095"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 06:06:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 26 Oct 2026 15:06:16 +0200 (EET)
To: Denis Benato <denis.benato@linux.dev>
cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    linux-input@vger.kernel.org, kernel@lists.opengamingcollective.org, 
    Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
    "Luke D . Jones" <luke@ljones.dev>, 
    Mateusz Schwartz <matthew.schwartz@linux.dev>, 
    Denis Benato <benato.denis96@gmail.com>, 
    Jonathan LoBue <jlobue10@gmail.com>, 
    Khamunetri Clark <khamunetriclark@gmail.com>, 
    "Derek J. Clark" <derekjohn.clark@gmail.com>, 
    Joshua Leivenzon <hacker1024@users.sourceforge.net>, 
    Nathan Chancellor <nathan@kernel.org>, 
    =?ISO-8859-15?Q?Rebecca_Mara_M=FCller?= <rebecca.mara@posteo.de>, 
    Ivan Levchenko <me@livan.pro>, Corentin Chary <corentin.chary@gmail.com>, 
    Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v11 07/18] HID: asus: add support for response curve
In-Reply-To: <20261025235232.129945-8-denis.benato@linux.dev>
Message-ID: <7688fc40-c439-005f-6a78-efdc39356694@linux.intel.com>
References: <20261025235232.129945-1-denis.benato@linux.dev> <20261025235232.129945-8-denis.benato@linux.dev>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 25 Oct 2026, Denis Benato wrote:

> ROG ally devices allows configuring the response curve of both joysticks,
> therefore add the ability of userspace to modify the response curve by
> exposing relevant sysfs attributes.
> 
> Signed-off-by: Denis Benato <denis.benato@linux.dev>
> Signed-off-by: Luke Jones <luke@ljones.dev>
> ---
>  drivers/hid/hid-asus.c | 297 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 294 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index b4bc89ec28bc..e1883ee20413 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -22,6 +22,7 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/cleanup.h>
> +#include <linux/ctype.h>
>  #include <linux/device.h>
>  #include <linux/dmi.h>
>  #include <linux/hid.h>
> @@ -185,6 +186,18 @@ struct asus_touchpad_info {
>  	int report_size;
>  };
>  
> +struct ally_joystick_resp_curve_param {
> +	u8 move;
> +	u8 resp;
> +} __packed;

Add include (if I didn't mentioned it already with some earlier patch,
I don't recall anymore :-)).

-- 
 i.
