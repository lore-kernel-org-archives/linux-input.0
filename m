Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEB93F7A95;
	Fri, 10 Jul 2026 12:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783687380; cv=none; b=P6TfJrNieltivl46OKY0WIy81l2mgyS6tYQ2tAJXmtVfHFQxs5v0DoeJhXEow6LaiWtuGOEHwuSwa2ygGt3ZTvdg6BkWorx5UeymedxZ+G2fo6kXPVZRmOQlGwO3dfrIinH/03SAdbd1t3PxyNvBOydVtN6nN1+cF+vFwL7OByc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783687380; c=relaxed/simple;
	bh=UgZyIbQNVfmbsugM1aplo+EGpxTGXDDCBBHdnB8E4Dg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BzqtUnWI+e4hqN/+oXIHuaWudhfd15Ti0n6fzJHkBF1Im1ZBzKsWHVaFUeRMFjzEzr6q+eN21+YTGb8FFL7Pw83hGPvjkdqe/HcKykwyGxYvAwiXS2d/pTlqUXCK1jv6HqycuuGv5an653h1eyorFyIQjkkd56AarJUIka9GBVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=YJbFJRUO; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="YJbFJRUO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=VEHZiw/6FUwIOcw6nopxjpmpqjEgZaz22mSg/mOI1Wg=; b=YJbFJRUO9MQC3B6n1gRS8uE86o
	B56pj0ySGiaf7ycuwUQfJBN80TsAfGIPookWRJjcOyVclYlrAQtqpjQZG39xaVBX/eKK5LqZ2prY1
	LIT0wTqNE7pVS1iEiV8F+8rw7KZDh9xzzIUGpIpX03LxCYaiVVE54kZ5T03rFxPnlZco=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wiA4M-000000002Nf-1gr5;
	Fri, 10 Jul 2026 08:11:03 -0400
Date: Fri, 10 Jul 2026 08:11:01 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Manuel Ebner <manuelebner@mailbox.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: fix bracket
Message-Id: <20260710081101.55994bcac1c76f4d3113c204@hugovil.com>
In-Reply-To: <20260710090153.431170-2-manuelebner@mailbox.org>
References: <20260710090153.431170-2-manuelebner@mailbox.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --

On Fri, 10 Jul 2026 11:01:53 +0200
Manuel Ebner <manuelebner@mailbox.org> wrote:

> [You don't often get email from manuelebner@mailbox.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Add missing '('.
> 
> Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>

Acked-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

> ---
>  .../devicetree/bindings/input/gpio-charlieplex-keypad.yaml      | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/gpio-charlieplex-keypad.yaml b/Documentation/devicetree/bindings/input/gpio-charlieplex-keypad.yaml
> index c085de6dab85..c6842c017934 100644
> --- a/Documentation/devicetree/bindings/input/gpio-charlieplex-keypad.yaml
> +++ b/Documentation/devicetree/bindings/input/gpio-charlieplex-keypad.yaml
> @@ -11,7 +11,7 @@ maintainers:
>    - Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
>  description: |
> -  The charlieplex keypad supports N^2)-N different key combinations (where N is
> +  The charlieplex keypad supports (N^2)-N different key combinations (where N is
>    the number of I/O lines). Key presses and releases are detected by configuring
>    only one line as output at a time, and reading other line states. This process
>    is repeated for each line. Diodes are required to ensure current flows in only
> --
> 2.54.0
> 


-- 
Hugo Villeneuve
