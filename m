Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4003A3C4B71;
	Tue, 12 May 2026 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600916; cv=none; b=GB8PP7aofBiu5f5eGcu6tnnllhK6u/q2zPC3M1Fih3+q4Ih9frTiRqXj2XAneuAjXvUxvIVh4GfURM+Z3FBUlYScmxmYd4K1p97kwMKLnknb6Z4EJ7nJd2MVJhP18pAmOZh/Sg+URpcJDlF0A1HsELeEJaQ8A4ZiLCVs/JxlYD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600916; c=relaxed/simple;
	bh=h6TI3fRYcu7jE1vMi+cETt5NPGKT82lG9BXPRnALDs8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eGnbPzvOqxISZN6XNLLxWCZb3xPb4eCrMxancsKlrB6yuErHEzeP5yzeZHnrmU4J96tqRedHCAWLwvgBZWhKVC3Brmk7exJQq514WBEKpBXtSBRCidSEtK3NzT5kFO9cf7I5vu76tXiC2ljkCKoAjRhXSBY/345UB69my6rWBkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGITHCPB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGITHCPB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DCA7C2BCF6;
	Tue, 12 May 2026 15:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778600915;
	bh=h6TI3fRYcu7jE1vMi+cETt5NPGKT82lG9BXPRnALDs8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=pGITHCPBeKroLqfSFSiRiHq3VKYoA538+WbuOPTO4btQcwC9WAOTvDX9YFY+KEcYf
	 7O6h3XQfuxjYx2l51Kasqztn8c/r/WQqv9KGHNacuzZbZm45mX7Hqe6MzkIneNdsue
	 jHgvXsphmZkQ9dYffH1WNzgoDqXap4RZGOMXZVIa1oSbECTV+kenrtTJPjD1EO8/Yg
	 9swlgyCt5jA6bCigvxBt2CqRJGTDdHqmRD/+3lM9hTV1H7S+R7ReYv9a2Hdx6sZNW1
	 G1ZgACrONRS6t+ASQSIGm+5i+cTG/2hepvfzNppMvNbG7dc3OJXK4hM4qP9oxnSwcP
	 1rIXOtgPKmP8A==
Date: Tue, 12 May 2026 17:48:33 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Florian Pradines <florian.pradines@gmail.com>
cc: gupt21@gmail.com, bentiss@kernel.org, linux-i2c@vger.kernel.org, 
    linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: mcp2221: fix OOB write in mcp2221_raw_event()
In-Reply-To: <20260509094517.2691246-1-florian.pradines@gmail.com>
Message-ID: <623310q7-r14n-ro96-0rnn-op811r21s2sp@xreary.bet>
References: <20260509094517.2691246-1-florian.pradines@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 9 May 2026, Florian Pradines wrote:

> mcp2221_raw_event() copies device-supplied data into mcp->rxbuf at
> offset rxbuf_idx without checking that the copy fits within the
> destination buffer. A device responding with up to 60 bytes to a
> small I2C/SMBus read can overflow the buffer.
> 
> Add a rxbuf_size field to struct mcp2221, set it alongside rxbuf in
> mcp_i2c_smbus_read(), and check rxbuf_idx + data[3] <= rxbuf_size
> before the memcpy.
> 
> Signed-off-by: Florian Pradines <florian.pradines@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

