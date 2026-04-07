Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DD32652AF
	for <linux-input@vger.kernel.org>; Tue,  7 Apr 2026 04:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775537346; cv=none; b=c+Z/8sAupGGTtecq9ZyKcRiSoYCmLNaSELEZb8Ld04YyvFIcjbL5wUGqiraHC7WAQlyRs5hNDxqBaxyNqgQ9M/yb5/aTsnY8Ydt8xdF3uHToTVTLS783nCpQrQGOleQi67Hx3qSJ6wIvqG0Wnko7Rp+i+1eeiJRLAlLqP95dE54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775537346; c=relaxed/simple;
	bh=KN10ixWyhSiQO6k2rgognDXtkp2e3lun0UE56kDb9Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luGywACikDfFDHh9u4AThdHkvusBORfV0FCInW7/JMpP7i6B+uenUXARpzPTb1ppWycWTM+GsuGFHvThvrWwdTWAT7v6qPYDgffOM4HtUtwjVk+Erl0mKMUgfQd77B7YERpx+HrcIVweelhuq6AKXLl7OulD/y3Zvv9wN3VELgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N43ZuFzD; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N43ZuFzD"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2cd339aeab4so3247621eec.0
        for <linux-input@vger.kernel.org>; Mon, 06 Apr 2026 21:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775537343; x=1776142143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gk8b5C5Z9p7AhhgVp7PgvI/D1cC78P2Rxt1Jreg7P9I=;
        b=N43ZuFzDCEkb9OyW8Nnts60N57hAkqcbfWr8VScF7h3HdB4KisYXKuxvfI6di9MPMe
         oqcI9fRx1gZhU5SLzSOrYVDf4NtDLjolzk8TRFXY7UkeF1n/v6N3BKBty91tOQ9MRM6U
         uEnKu3KZUa8xyybdb456yrEeFexW1Oy4QZvdnXTibWx0nBzxNvT3RRb29pqJgK/Td5yW
         M2T3Nu/Z49pdKoe+Hmei0JjvVEeYdb9bkzB7/PiEauce5sNlPCrEtSOLAxQB2nSIvrBR
         bGHx9+/JBQ6mS/03bfSfGD1VlnMIcu/zfTxlUqwtkxsrqf+bWqZshJ++Sp3hJN29HwDe
         Fs1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775537343; x=1776142143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gk8b5C5Z9p7AhhgVp7PgvI/D1cC78P2Rxt1Jreg7P9I=;
        b=mykwNldW5twSlqiP3kSOBtZ3evV9I07LdQJ/NAmKRZU9ldYO1CZ1tckhsNEF1HOuZ7
         //cf/3idAMy/QrD6zRHjZHYHZhMpj0hB8+7ErDN0j1MKra3M8ooIfJz07W1zF6lSv3Xi
         4KE1oOACbNay4h0xIp4a+Yj35gb/5lBSTl2w/5p+iKcLWQZAlYDffOQ1HCJO/6hbzu5k
         Byw19PATFFptPnORlyLZDFWeR1t41GTajXszud5bvSo5aW8y2wVRKDtF9+WVqTCVVF25
         w/CvBcFYMm+1BuwK/cARBsfOL+yrXnCSR27NG6I1HFuxr2uuOaRcAmNkcwRFZEg5MqJt
         LdKw==
X-Forwarded-Encrypted: i=1; AJvYcCWlj9OdhWBgs52ECYWYgOJGix4EdyUvbbq6+uAwx3WUtMAps4WSzUwAOIgSHib9y+VwhDPGrdByr+cI3g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz07aSdATnHxE37SSMDHjakYjx9IZsgAxK60dgeTcwcqp4PQV/I
	1bxxTWQJR0Aps5CDhVtwZv8sz2RKU+CQAWxNMH9hK4BF9Mo18OVcgLXX
X-Gm-Gg: AeBDieu/sk5ps0BSFJGGQJh0kLgfRxQXAbBiw996eS08CHUMoP4nQrlpRMRjTq3Mcad
	9lgFRqAx8bEgCFp0LZDIa8zSH22Rxm1ELmDXDWNEQqC2loDcLN28W9LxMMWsNHEovFVvHL9qS4s
	x3iW9X2lvvxCqWdKBahB+FvtzjGWxRaUSuOCbBjEcU6DNNJKwXGKxN0HPhm2etqCAUfBIn0Xhqq
	P0C8Z7q1KgF1lN7varmSMzfbUPUYf7pzN/rvBMuAmuz0XJv3soEXmQHo6eJxUKnevwwb2ZGgrV6
	zbTSq5UrKzxkL2wx32z3RolxKZhSwvWaIa5Af7Fejwtkyzn7gsNvlVtf0FFaS1O2muACjDn8InQ
	MdjHGjapyyBOVZcijQQD0Rkm8rKvtLUkpJbJomDSr7mC0Wrq6YxH5lEg+te+osrJDxvDIPiB2p6
	4n5ZmM52eKhPPtwHLV/mvhiCtAodqx+88dyP7fdfthUQH7Y3Um9RYx8shLFKmiE33WygC4I4+1g
	fA=
X-Received: by 2002:a05:7300:dc88:b0:2c5:b23e:48a4 with SMTP id 5a478bee46e88-2cbf69984ebmr7281281eec.0.1775537342525;
        Mon, 06 Apr 2026 21:49:02 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:dd71:7176:b4e4:a7a5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca78df5ed3sm14644119eec.6.2026.04.06.21.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 21:49:01 -0700 (PDT)
Date: Mon, 6 Apr 2026 21:48:58 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, 
	Casey Connolly <casey.connolly@linaro.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v8 1/7] dt-bindings: input: syna,rmi4: Document
 syna,rmi4-s3706b
Message-ID: <adSMQXgbco8fvRLo@google.com>
References: <20260324-synaptics-rmi4-v8-0-2168d2df68f5@ixit.cz>
 <20260324-synaptics-rmi4-v8-1-2168d2df68f5@ixit.cz>
 <acLpBXc9Qi5riQO0@google.com>
 <5630a4af-e18f-4daf-9b04-ea61091d9e51@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5630a4af-e18f-4daf-9b04-ea61091d9e51@ixit.cz>

On Wed, Mar 25, 2026 at 12:33:23PM +0100, David Heidelberg wrote:
> On 24/03/2026 20:42, Dmitry Torokhov wrote:
> > On Tue, Mar 24, 2026 at 08:40:34PM +0100, David Heidelberg via B4 Relay wrote:
> > > From: David Heidelberg <david@ixit.cz>
> > > 
> > > Mostly irrelevant for authentic Synaptics touchscreens, but very important
> > > for applying workarounds to cheap TS knockoffs.
> > > 
> > > These knockoffs work well with the downstream driver, and since the user
> > > has no way to distinguish them, later in this patch set, we introduce
> > > workarounds to ensure they function as well as possible.
> > > 
> > > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > Signed-off-by: David Heidelberg <david@ixit.cz>
> > > ---
> > >   Documentation/devicetree/bindings/input/syna,rmi4.yaml | 11 ++++++++---
> > >   1 file changed, 8 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/input/syna,rmi4.yaml b/Documentation/devicetree/bindings/input/syna,rmi4.yaml
> > > index 8685ef4481f4a..fb4804ac3544d 100644
> > > --- a/Documentation/devicetree/bindings/input/syna,rmi4.yaml
> > > +++ b/Documentation/devicetree/bindings/input/syna,rmi4.yaml
> > > @@ -18,9 +18,14 @@ description: |
> > >   properties:
> > >     compatible:
> > > -    enum:
> > > -      - syna,rmi4-i2c
> > > -      - syna,rmi4-spi
> > > +    oneOf:
> > > +      - enum:
> > > +          - syna,rmi4-i2c
> > > +          - syna,rmi4-spi
> > > +      - items:
> > > +          - enum:
> > > +              - syna,rmi4-s3706b  # OnePlus 6/6T
> > 
> > I thought that all the workarounds will be keyed off this new
> > compatible, but I do not see that. What am I missing?
> 
> The compatible is used for sequence in the
> 
> Input: synaptics-rmi4 - support fallback values for PDT descriptor bytes
> 
> where it is used to provide values missing for OP6 (and possible others in
> the future, when added).
> 
> From my understanding the series, only two patches (1st and last) are
> specific for the OP6, rest will likely benefit various TS not implementing
> full Synaptics set. All measures apply only when touchscreen reports
> something wrong.

If the sensor does not implement RMI4 protocol properly it should not
use rmi4 compatibility. I will not apply any patches that work around
incomplete implementations unless they are triggered by a dedicated
compatible.

Thanks.

-- 
Dmitry
