Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5923C1F46;
	Mon, 14 Sep 2026 23:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789429534; cv=none; b=LkJSQJ6pQpQ1h8CV7PZb0EyjKz9zle5DE+4s6vp8yiwaB10qVuq3YCQbWWQ7neFsoZ2HD7cXygqt5yhAVpUdqjwzdXDWwtL11utXfjBvZWZ5IISFgDspSgDH59VKwUAQ2eZdRodXhQzf2tBqcWUZ3z3Udb+kZswfQttzS6GYabc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789429534; c=relaxed/simple;
	bh=jmrPEQHq/n4DIP48MQLmQgZDGqLcOvLj0wyXI/WV35c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dhvvBobv9U49XGYvjM7XgqZkvgrHHpXsGZkiYOZ3OnkjF6Q5VUz6QvHOtjDwPp3hp9Ewx5sdA+3t9fE77R1tG2N8BnKRhWyfsKtGLvUb7HqLRDaqF67bgy+Efk7MpVZ+hNU3v/Ja9sGuszsV+S78ZFlVuyiCJgs8lWsM5IRfEzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWhxrZzS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWhxrZzS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A531F000FF;
	Mon, 14 Sep 2026 23:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789429533;
	bh=jmrPEQHq/n4DIP48MQLmQgZDGqLcOvLj0wyXI/WV35c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iWhxrZzSK83FeveUqFqrVGHuBMaAKcUhPXbj/GJfWWwiyXpxNnKNqce8kU75WwTb+
	 iN14J8sWwpzcZaL3vSrIuBOIdixH+BCDevPoN1rZMWrpOxo4KcuhBQEVakeiiojhE7
	 GRDgbf/2TxbMqlBsUVOjQ4f4zO/i3CTxUKsgz4SemKCnmgecBUHWzDhOsSLFTosjdX
	 X6/3fSgg9pHMyCYMMItylzHrVAbEuAvswxkM3EK8tDpiPlbY3Zo/Xmd/ERmExA+3kf
	 ksbsh7CzOpYCkhwXlQqyNiXX0iU9P/YDiKFXOCjwgGr0X+tDXRO/yMjVbqEYmfeTMw
	 z/+i21DTvR/Uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] HID: generic: Respect specialized drivers match
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vas Zayarskiy" <contact@vasily.cc>
Cc: linux-input@vger.kernel.org, linux-hwmon@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260914233728.22725-2-contact@vasily.cc>
References: <20260914233728.22725-1-contact@vasily.cc>
 <20260914233728.22725-2-contact@vasily.cc>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 23:45:32 +0000
Message-Id: <20260914234533.20A531F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> A driver can reject an interface in its match callback even when its ID
> table matches. hid-generic currently yields based on the ID table alone,
> leaving such an interface without a driver.
>=20
> Consult the callback after matching the ID table so hid-generic can keep
> interfaces declined by specialized drivers. This allows the AMPINEL
> hwmon driver to leave the separate keyboard interface to hid-generic.
>=20
> The same callback check was proposed previously for Logitech devices:
>=20
> Link: https://lkml.iu.edu/hypermail/linux/kernel/2212.0/06724.html
>=20
> Assisted-by: LLM sparse
> Signed-off-by: Vas Zayarskiy <contact@vasily.cc>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914233728.2272=
5-1-contact@vasily.cc?part=3D1

