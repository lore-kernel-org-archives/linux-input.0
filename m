Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B7C35B127;
	Thu, 26 Feb 2026 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116072; cv=none; b=TLavI2RZlN7ci/7n6G3z20J4vHLdJheqPQeQIvA0FI1tnEnHgvvL6OlbgHWUSeyUpaIBh0iEv7kh/3XUXrpg8v3qo/LsPJMnlnZPa31cUGS0Ut589UJJaHfsJSgXzCA9pzG3w9YLGJErOMhdyo3AvBg2uRcL1yLm8F1e4OcC9XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116072; c=relaxed/simple;
	bh=sOso6PLU9y2Yr05jbPsylZojXDE+UMjfWA7ttI4ixgA=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=XKaucXFkCKAmifTj3toxB8RXdWwYo7dBGI5b0Gg5gVosx0WNSNNRL8FbwXDSM5Re3vNdQPRYuBpnaSuau5QOXA6t0W/bwrk6rBYm+P4sx3pEib4dh+Wa64OWkYESt4UdP1GnVrTW4YovTsB92nViK+rcuTkm81/9M5qKMnj9EDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=ezQqxS/G; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="ezQqxS/G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=uA5Zk/FAFPoXM9HYbQGs/07GbIQjoWnoGZNlTmfaEUw=; b=ezQqxS/GvAZg6tPm+7TafBbDIA
	pl4J89bFjjbp5ASbnepvf3lTkfXt8GqigtkK4gKRRizwff3F/bLZbBjwST4xBQHZIau3R0rs2GfaB
	IKg2vTguXgq668x6g3qQPAg3uGb3Ko7/WP9RJSynJu/dTPSkliFirSoj37TiK9sL6EY0=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:33022 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1vvcKx-00089B-NR; Thu, 26 Feb 2026 09:27:32 -0500
Date: Thu, 26 Feb 2026 09:27:30 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: robin@protonic.nl, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dmitry.torokhov@gmail.com, hvilleneuve@dimonoff.com,
 mkorpershoek@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, lee@kernel.org,
 alexander.sverdlin@gmail.com, marek.vasut@gmail.com, akurz@blala.de,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Message-Id: <20260226092730.3dd39a4e55e8756e2fbbe927@hugovil.com>
In-Reply-To: <CAMuHMdVd0Ds5vHQa+MG2E+E36qAu5HQE3b+Vzpbv84MM=2DFWw@mail.gmail.com>
References: <20260225155409.612478-1-hugo@hugovil.com>
	<CAMuHMdVd0Ds5vHQa+MG2E+E36qAu5HQE3b+Vzpbv84MM=2DFWw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
	*      [score: 0.0000]
	* -1.9 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v3 0/4] input: add GPIO-based charlieplex keypad
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

Hi Geert,

On Thu, 26 Feb 2026 10:20:33 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Hugo,
> 
> Thanks for your series!
> 
> On Wed, 25 Feb 2026 at 16:54, Hugo Villeneuve <hugo@hugovil.com> wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >
> > Hello,
> > this patch series add a new GPIO charlieplex keypad driver.
> >
> > The first two patches simply commonize two properties that are present in
> > a few bindings, so that the actual patches for the charlieplex keypad driver
> > can reuse them instead of also redefining them.
> >
> > I have tested the driver on a custom board with a Solidrun RZ/G2LC SOM
> > with three charlieplex keyboards, all connected thru a single PCA9416 I2C GPIO
> 
> PCA9416? The closest I could find is TCA9416, which is something
> different.

Its a typo, it is PCA6416, thanks for catching that!

Hugo.


> 
> > expander.
> >
> > Link: [v1] https://lore.kernel.org/all/20260203155023.536103-1-hugo@hugovil.com/
> > Link: [v2] https://lore.kernel.org/all/20260213171431.2228814-1-hugo@hugovil.com/
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 


-- 
Hugo Villeneuve
