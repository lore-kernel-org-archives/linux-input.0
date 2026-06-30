Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09854346E57;
	Tue, 30 Jun 2026 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826626; cv=none; b=drBf/AXtpttqIzaDxZvm7DPcJpMJCp/So1Y8Qz54Ry/DSrfu1w64Ya4fNN6ohS6D/9tbLBMbVFyA1LFPOPS/0+fU3NCmVWgWKKwjI5VjhD7pMxVBOXTF7gduC8sQIlxmMYMxMEeADPjXe67e4i/14NrIEdlJPZjXh00AbPYwIv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826626; c=relaxed/simple;
	bh=gM4ptWWmX8aa9w3Fu72eLgj4GQupLVH4PZcZ+wIpjJM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GI/tl31QLdGzjoNikVQ4KUYJVJTYhLJ1wndksxmlkFpgdldy+o/lt5AhTHR2xSsHv6ZD8omZtUTeb2uu0raiYV+jN4W/SQSZA0ip/c4lda6ja1FJqg3nD1dwkKdc+JiLIyKNmGmbdDSCA453TuidsOpKuxweQwoF3jejNixxy5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpqAybZX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpqAybZX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BFF1F00A3D;
	Tue, 30 Jun 2026 13:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782826625;
	bh=g6c/viXKJlxzF9u4S4EmpJmpsIKRF3bUrIcX5yJmE+Y=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=OpqAybZXHxFtrF6N/hxmz1wAmxIZYGsDD+Py4UOkpkRc+CAThPc6vmpq/SZENMiY1
	 0hOmVUqWaoJTbjIy74TVHNwNcbOjdmp3sxqrtCimwDFTHGWRXo9XyN9+JP4fRd9O+D
	 WW4owZO1qxhgcS+tzokn5AstdCHn8qJsmFOS6yFJzNrzksjJGVPXcV37iG8p2bcjq0
	 c0IetjgariIkjvUHCVDLfXC3HwGX+/n0KjOOL8uycZY3+jVc5xcsaOFwJXBhYoC0Io
	 +/ZmmvbMn7miCVZQt9/gRqbZeS6du/GKHs/plGmvszA7+59pFleWpc7C2Nd5rNwakt
	 TG43fJhSkhdcg==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5DBEAF40069;
	Tue, 30 Jun 2026 09:37:04 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Tue, 30 Jun 2026 09:37:04 -0400
X-ME-Sender: <xms:gMZDahTtDzdiCTmc3wN0tDBcF111scEoRJzkja_3VMwmL7xrl6pMJA>
    <xme:gMZDalm9xoKWTcdRX7xgnlN4FJjKY-S6OMk2zsLCrRH7p6JM6wdMOlZrCap4ZVe8W
    uaMlN64yGYJ7jHG5FnTK5l9pb8vVOZh8IwPE8-cI3PQ6tr53V-76A>
X-ME-Proxy-Cause: dmFkZTGntHedD7x5uySKIpzMyZeHjGX1/v5zb9a7J73CJk60GIwiHVy2puFWrUuOB3dmBY
    GICXnrmvkHO1OeiXkN/wRlzjy3BWBylx4mnzMZgNS9ea8mUthQy6KaF06IibcLfq72sYtZ
    weOGgSRzJT+E39Uejx+s35lTxo4D0RFK5XCGYBbBho3Cwzx0csvA+Rxp8iNH+ldcxEDlkM
    Fk3ikuFlWO7nu1u8tTGzv5jQkc+DYupnUSZJoigJ7xDF4aYm1zj+Gn6UAk6e8Cv66twnU4
    V6S2sCBp/o3I7HeQfd2FnDvmmLAuet+npscXtRQzTmo6eOlode9IebhhZSpMfPaHp8rNoh
    H2L9Yi57aD+662pFwEe7tjLw0xRz7w2mH5L6sJbBTsbjylXPOZ50A9j8QjWmQ+1nv9wwRX
    73po1rv8upOcZBz4Sgh9ybUU70nNtjMdWur2lEdxWAzQegVfayiEKFpui+Q1IFjJfAb6bl
    JATAFX11erGLvmTq4pWBvsQTeLXhqhz3aCQ7AdK3EgcmPPTo+9rKpR+XyBEwOpzTvn5Vlv
    II8OFOuMcJVIaqqa60BneM2UH7qYAafZzXsezIner/q3ZOVWit0kOPgAGbUVojzxuFR3jh
    0jacOnc9uVAE3SywmBKl/LQXoa0UgjsLOum6XLT88MZnG/79I+ezLQtNl/6A
X-ME-Proxy: <xmx:gMZDarOqll2gi8jYNakSBTdZjeuMkQnue3kVb3iucZrSg2FOK_i9cQ>
    <xmx:gMZDaq41FNvYvOoRrBWa2yFkNYxz3_0iHQyoPeS5UXMKm1reADhcPQ>
    <xmx:gMZDauhevVGM-uJJZCinIGNf8ZRZixWGrXrrpY9WsLWJa3pHczNc7Q>
    <xmx:gMZDaveOZ7DZ66XB4cs30ab9shTmssPf3RDJ25siP1IyYnvm5kNMZg>
    <xmx:gMZDamzFRO0c-J0rxtjntKZnfKC-cOeNJAttr7AZJAGdqv9wpPS2uCLk>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3D5D5182007E; Tue, 30 Jun 2026 09:37:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Awr8XjsC6ZY3
Date: Tue, 30 Jun 2026 15:36:33 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: "Vladimir Oltean" <olteanv@gmail.com>, linux-phy@lists.infradead.org,
 linux-sunxi@lists.linux.dev, "Vinod Koul" <vkoul@kernel.org>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
 "Neil Armstrong" <neil.armstrong@linaro.org>
Message-Id: <8b73996e-df5d-469b-810a-868782d8abf2@app.fastmail.com>
In-Reply-To: <20260630132833.450051F00A3A@smtp.kernel.org>
References: <20260629132633.1300009-1-arnd@kernel.org>
 <20260629132633.1300009-9-arnd@kernel.org>
 <20260630132833.450051F00A3A@smtp.kernel.org>
Subject: Re: [PATCH 08/13] pcmcia: replace linux/gpio.h inclusions
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jun 30, 2026, at 15:28, sashiko-bot@kernel.org wrote:
> [Severity: High]
> This isn't a bug introduced by this patch, but I noticed a pre-existing
> issue while reviewing the GPIO include changes.
>
> Does the error path in h3600_pcmcia_hw_init() cause a double-free of a
> devres-managed GPIO descriptor?

Yes, there are many bugs in the old pcmcia drivers. I expect that
we will remove these soon, as I plan to drop all the sa1100 and pxa
board files early next year.

     Arnd
