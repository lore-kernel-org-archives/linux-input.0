Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839221;
	b=SmQWZMUOroB9Kq7SfWrrr5pM8LnIhb1i1AFmkNqP+z6ytqF6Z/Ps0bFYBc5PdsXh+ORx
	 j/rEwUlIeWkpxp18sGBrxgaLW+GZ/zDdNQ7RXzToQGY95hzpFlmkVJ2AqdpfqgeJN0NYz
	 n9/rgXILZaXzJUUOKyKK4cAagqVEXJgeHcuplhFZfn/JIVNhB68iYf9PY3FZ+4NYALSRW
	 iW3NQn7m9v21J/3fWMhbtSaorYEOX62SF8FBtfuYCevcf/fJnOg0SIt3u62u5Zo4kJYJ6
	 Id3tdLT1eLi6uH2DHEgUlmA81x3p5WL+FYpD/GDtCs1yNxusL0z9VzMEpr0r9CoMGOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839221;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=REYPW0V0Hw8OeT1V1MVJj6gyXDEMPTMuQhc+KEFGz8g=;
	b=ffSQjEGdIJluIgh+XcyoaYgjzzw2v5+tJvaGJxXrl2J4JRtoZqwMecsTi0m+Xb+qbiZS
	 Wl1ObwXwfbSCRw+rd6r8JbwQYNa+A1cNi/fXqpJzaXoje2fgHPAL0jAsjg7Yw0Ykd1C+Q
	 YX0StmVsUvKaMFkIxblqN/0V301RWiFo5j+0ZyU+YkEMk9W3QudqkaI3EDylrwZLcQS8v
	 ylQq2psoakg2ASQ8nMbbOtgUZQxc0mywT+OGq+LDrxduhsBu+M+pGbWl22HsBHP2UfZ1q
	 MTXys8IIX+0mriM/qqslJef7/4HXNBp/uFcYMcazm8Mvs8f4tgyD6SvlcyX9p4063AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=ti39duon;
	arc=none smtp.remote-ip=35.89.44.33
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B10606A323
	for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 14:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68B10606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=ti39duon
Received: from eig-obgw-5007b.ext.cloudfilter.net ([10.0.29.167])
	by cmsmtp with ESMTPS
	id SwJWxx56rAR1iSxfhxZU7d; Mon, 16 Nov 2026 14:27:01 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id SxfgxM2mWxqjjSxfgxAtjE; Mon, 16 Nov 2026 14:27:00 +0000
X-Authority-Analysis: v=2.4 cv=bZxrUPPB c=1 sm=1 tr=0 ts=6afb12b4
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=pGLkceISAAAA:8
 a=QcAV74sXaHvaKY3IglgA:9 a=CjuIK1q_8ugA:10 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=REYPW0V0Hw8OeT1V1MVJj6gyXDEMPTMuQhc+KEFGz8g=; b=ti39duonapH/OckZv4V65mFYnf
	zWs7h8UMwiLZo2J345Xd1MIc1V2i/uT11BD6YIUFmVrEqZCXsO9fQ1jvtAMaO25lWzhppbx2yF+4u
	ruqcZar0Loo0GHdG2gXsWh00FxIPx//KLYx+ZSiejT9Qi/DGXN7R6mXNzw9gYS4vTQNJ/10Ab/vel
	6UzeNg8+YQpL9dna+rPlI4tCX/xCL97vCOg7jIrOKSBgj3i/jUU+LqBtA+4YXaBSiWjNtWS11PqA5
	m+DBvkQP0aGuSlKhPgzQtbh2iK4SnicdvXrN7+1See3aaD7idxTocydr4+J8Q01Dmh/veAdatWoae
	3zPs4Pug==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:49322 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xSxfd-00000003oF6-04lF;
	Mon, 16 Nov 2026 19:56:57 +0530
Date: Mon, 16 Nov 2026 06:26:56 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Alexander Letuchiy <asalde.le1@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Mattijs Korpershoek <mkorpershoek@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-input@vger.kernel.org,
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] watchdog: mediatek: Add support for MT6895
Message-ID: <eaaa1e62-ad8c-4cd7-9855-f8efca36cb70@roeck-us.net>
References: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
 <20261113-initial-mt6895-v2-4-4ab0aa9fa391@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113-initial-mt6895-v2-4-4ab0aa9fa391@gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xSxfd-00000003oF6-04lF
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:49322
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 52
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMX5sX79AU/eQWAGMyqrSdFJYX5IDGBsejFw4DciGrEoU56aYhmMPqKvo0hUEda/hmlyUpPNE2eMoYBE6iLrQOQoBGu1jhBlcsQt/fztadkIqzyVVydg
 QM7s1XephiaijzjpoBvXpgLWIm49h37ZgYZ+LlNxjZAx8hCr+J4p1MHDmNXAX31mK9mJsot1dh8P7P5WSAv8RghlzFVoe8UBwPhDpI7qwXBCXOks9CLU86oe

On Fri, Nov 13, 2026 at 10:05:00PM +0300, Alexander Letuchiy wrote:
> Add the compatible for the watchdog of the MediaTek MT6895 (Dimensity
> 8000/8100) SoC. Its watchdog registers are the same as on the other
> supported SoCs.
> 
> The TOPRGU reset layout of MT6895 is not known yet, so the entry has no
> match data and no reset controller is registered.
> 
> Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>

Applied.

Thanks,
Guenter
