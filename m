Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30E237B409
	for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 19:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783712204; cv=none; b=RSZMKuqIPaFcKJOysaPAEB/3SfYxL8FjNH9rs8KcSg7iW3UjVWTECV9YbHMHUqH8g7iUHi4lxv1i14TRBAu1HSNdFLM1+XZazYL/W3lKsIb0lDGDVNcV7/cPHPt4Uq2mHSe1UACobbD+qPCM/VG4mxBMPB3qaKn1XKJvldTxL5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783712204; c=relaxed/simple;
	bh=8ikMJg8bvcWDMfWXN7cUWZlI2PFYV3XHhHWQI6jeqx4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=lhvC5SUqC0XsWANNZK4M43C9Dw7YVVShIGVhv8zB7SLqvG2VXWM5hCK+f8XiwNss+rjNwMDzmevKFhG/28IQAIuA1bXhqfHaxh309ToTGDUcIzw6oTntPF93eLEI/aqFDwInzeqQpCet2dWbZe9bIgA3XB+y88bAVP9yVYeAk7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=XRDwnDm1; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=ceRBz5Bf; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="XRDwnDm1";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="ceRBz5Bf"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=XRDwnDm1VEWBoiDCOBUrDQ7f+LGEcNX0nBgGMCZrD0JtNAFFzvMR9Ys+H+dI/aiwBOzboFCQZJ2rshPTpYreUyNotwxWkJki1mUPFthUy6WNk25cqqH0OZKGVewL6syaQ/PVLj0S4AanfepF76JdDAhSIm/sK23danAA/F/GpT0oNoNShUmpZZXjAIvxoN9p6hWBUw+KYGipLhn3uIdNAUJ5V1uHo9F5gXqiDjeSTDmToAQMQo5JRiWnaKcyfW5nUZZRkBwLm1elmgncuSAEVpODe8N8moZxxNtoU5FmJay5iFzJxdc1KJ9xl7cCLjUkGQakW8yL5XpCu8KwAz7wMg==; s=purelymail1; d=rcpassos.me; v=1; bh=8ikMJg8bvcWDMfWXN7cUWZlI2PFYV3XHhHWQI6jeqx4=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=ceRBz5BfIvPWc30ko2wj9cWuSyx9pCzriRm42AXZYxOb68x0r5JsPms1BFLGiXwnwF9rsKekBMN78YnB9jzQfTH72HdAjxM89j8ZqU/NTjBRV9NgNS7KdmggJcBWX9In9HYYxWfnQ5rXOoo3dVFmva2lVzSQPE6qrfOZjrqi4E3PKcI8Kmd/y63FBdEdgKpI3oMvPEmnZbjQuks/aM83bu+nZq5DbaU+OJKM0O2Z86C/YGo8GjBgnd5TVOdt7PpYSinqW+eWvPD6LYXEp4sgsnmzXmzeYIf+RGSnLoyIO4s4w03KKEjqqWWNakg/TFemLo8xvLudWMqikf/Hab2puw==; s=purelymail1; d=purelymail.com; v=1; bh=8ikMJg8bvcWDMfWXN7cUWZlI2PFYV3XHhHWQI6jeqx4=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 360692543;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 10 Jul 2026 19:35:58 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 16:35:52 -0300
Message-Id: <DJV56QRLBO6S.3H33MNASQ866@rcpassos.me>
Cc: "Shuah Khan" <skhan@linuxfoundation.org>, "Brigham Campbell"
 <me@brighamcampbell.com>, "Jori Koolstra" <jkoolstra@xs4all.nl>,
 <linux-input@vger.kernel.org>
From: "Rafael Passos" <rafael@rcpassos.me>
To: "Rafael Passos" <rafael@rcpassos.me>, <bentiss@kernel.org>,
 <david@readahead.eu>, <jikos@kernel.org>
Subject: Re: [PATCH 0/3] HID: wiimote: new LED behavior on connect, and
 scoped guards
X-Mailer: aerc 0.21.0
References: <20260710153456.2093889-1-rafael@rcpassos.me>
In-Reply-To: <20260710153456.2093889-1-rafael@rcpassos.me>

I checked sashiko reviews, and there are a few needed fixes.
I will delay sending the v2 by a few days, in case there are any other revi=
ews.

Specially regarding these two questions:

On Fri Jul 10, 2026 at 12:32 PM -03, Rafael Passos wrote:
> [...]
> The hid_info log message prints out the controller id.
> I was considering adding this number to the controller name too,
> but was unsure if this could impact applications using it.
- device naming

> The wiimote_hid_probe call can also be changed in this way, but I
> left it because it uses the wiimote_destroy in one of the err cases (w/ k=
free inside).
> But I can apply the change there too, to make this more complete.
- wiimote_hid_probe scope cleanup

Thanks,
Rafael
