Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8880234D383
	for <linux-input@vger.kernel.org>; Thu, 19 Mar 2026 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773925063; cv=none; b=RVhhQFhOjc1TkSd8NL5yQRLb0jNppgf6DQ0Zc2UDAGySTCLkj4cNBi2QdUsGCWKRCZC99cmNwMk3WdnbMox5A2WiT0T0URh4R3to8P2/ZzDt0nsY/l4pwLE53GNJKCyG6xsfRS4RQcHKtXWJfrbZ8JMbLqjRGfwnk7O6cE3vPgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773925063; c=relaxed/simple;
	bh=O8g2S9hi/6T+nQO9YFnnmEc97DjFk1yjeEIVXbSYm8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFeMqTmEMCh3T7NFHP0ZU2bJmui7VLmFSjetmVrQkQH91FKn3xAAMz8dH/aNby5k6gCtJ3hBrK6AKFr5ISI/s6738sV30L8izZFBp+ZhCdCUI93J/BwuJDn01iLi1L78J9Gn7ISnj9xBzS6777mKU5FNnLMeCUfm8I/v7Zmc6L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l55XMhXc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l55XMhXc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441C9C19424
	for <linux-input@vger.kernel.org>; Thu, 19 Mar 2026 12:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773925063;
	bh=O8g2S9hi/6T+nQO9YFnnmEc97DjFk1yjeEIVXbSYm8Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l55XMhXcLATxGH5kH1GYsPK1NRd3baIRrMU+Ff7ZfHki1JKvbtj+TV4+h+EPGJCt1
	 YjDWZ63bopk3CzbyK0qFNOpTiY845EihXQtSWQCZyl7DkPqIzkf5F9s2sDKHEpoSvh
	 AH3XPBAdsXBnADOEmUhQYXrzTWAPOZ5iw+cKL2iFtWbBtbPBc/6zLqWYuM2hGH5Hue
	 penTv4kbtGhT+QwkYaGyDM3/e+/Np/tZZ8/PecdS4chrUniDT2PLgpsH6HBxm1h8KT
	 IabYjZ7lsvsXOnp0SucDgd/OHYo0yGBGEYgAFOMnOzsYsH1lP09Vw6uJ01UNoYZ8uB
	 dMWTd2t3Dtrlg==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-797ab169454so10577677b3.3
        for <linux-input@vger.kernel.org>; Thu, 19 Mar 2026 05:57:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2tiB1krVdrQnCRZthNQPINuDgVkURPkIKd6BiupuuUzw31VtSz1IxVJKK+ajoXma9a5dqRJa9FdLFIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlN1JnZ18JYgIyiGVT1om8ehz73R1epgnEtRWQNHX/0RhXk90L
	ndv2MvsdWUM0KxKLda84VPVQTiS84lPMwpCxJxBhvPO8c0R25ar0Mbl/qb8r0Iex/+98P3Nfdd9
	QSEL78mfdIWmN+wnOkx4zXe/J9U413Mo=
X-Received: by 2002:a05:690c:a05c:b0:79a:4419:71a7 with SMTP id
 00721157ae682-79a71abd239mr56760257b3.30.1773925062633; Thu, 19 Mar 2026
 05:57:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260314170225.1260440-1-colin.i.king@gmail.com>
In-Reply-To: <20260314170225.1260440-1-colin.i.king@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 19 Mar 2026 13:57:31 +0100
X-Gmail-Original-Message-ID: <CAD++jLkO5kv7TcRM48cN+MOcJnUQV2TCNMmxGjc61vHa-5ynXg@mail.gmail.com>
X-Gm-Features: AaiRm528CurdZm1_vPfhViVN6lTQYL-bbVJ7a8AvfRPau16_BQcNzoHQgV6EBgA
Message-ID: <CAD++jLkO5kv7TcRM48cN+MOcJnUQV2TCNMmxGjc61vHa-5ynXg@mail.gmail.com>
Subject: Re: [PATCH][next] HID: mcp2221: Fix spelling mistake "Enfore" -> "Enforce"
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Rishi Gupta <gupt21@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 14, 2026 at 6:03=E2=80=AFPM Colin Ian King <colin.i.king@gmail.=
com> wrote:

> There is a spelling mistake in a module description. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

My bad! Thanks Colin.

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
