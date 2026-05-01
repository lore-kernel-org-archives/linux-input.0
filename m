Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA44282F29
	for <linux-input@vger.kernel.org>; Fri,  1 May 2026 04:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777610457; cv=none; b=S48Ee0hV1gaZIfQuieUCwZcHVX4ySRYbiO78hFfH73hYrqpLcFqBO+rtWS+5WqBFQwwJpwGcOQw9zqco6eEHMeWhoh/KQesqt68aYfeZnXZ+8GPSNOkqyXRQ4l6+1A3iiXdEq5Bd4d8gHZyhkAnI6Wrr2gB32fESYG5UNzz/PKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777610457; c=relaxed/simple;
	bh=EX7KAFJr96xQ59EGKzVx6fjgQt9QeaZA0pwXDyQCYB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muo/n9IpMr2XE8SWPKatJEJc8MuK3blpQx5HhTdDTEXyvDXI/RXkoCr9QEMoLDXXb8CZtGpKdrXAGqFNVJWN4vpSmp5R68tCellAJePy+Fm/Qeo1uOtH+inGOmWucJYI26fuBz4TR47bQhavjHowK0gEpJaWLIrs8AKFK1Ss4R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXx78zr0; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXx78zr0"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ba895adfeaso2001582eec.0
        for <linux-input@vger.kernel.org>; Thu, 30 Apr 2026 21:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777610455; x=1778215255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0LWyoeo3NEt+MnU9OPk9QlxsqZSS4FSkhsX0jbhKSRU=;
        b=ZXx78zr0ma+4mquFFx9bPhVw8Uv7G6O9z5Nrwq6L2tMGG8cTOR7w/wVecwPbTgYTmt
         Q2my1cAE7qYJp1prsH6IayT18NKnsnpWnSgkz8X3P141PeKzqzpusw3V0rNuJuIfQoa4
         1GLQTMYt8subzSzlhJMGBeKnHR1vbNv0BqupGhOQfgQFmvO/k8hEzVr6h8lAcR4x3vg3
         lWlPOLvL0xRbWUEWASUudsuG5TRGQunz+tNCVOdW+NAwNlcYuF5+7NPdFeHUlLq95N5/
         SwvzB49XJxQx7mozT+RTJwSOqP7mVjMd8dEz5rWa6HBKGrFfJBpzIKG5glIET50ZLu/H
         bAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777610455; x=1778215255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LWyoeo3NEt+MnU9OPk9QlxsqZSS4FSkhsX0jbhKSRU=;
        b=G9mjDIltWO4klNdxqDxKLU2GO/0G7IbmqWNnoKA/kper+Aqm6eaFw09ClpjsNHySM+
         ffQdogBipy47C3sMLk7DOlu8YzTltfuD90vCxvdzuujNZfIVrZfoBe2UAzIKo0TdHlfM
         m5AHd5HT5gu4wq1EgX4P1xo+jGOuzf8eicpyFeMXIivJNDmxiB61acTJOXj6oQ+veSWN
         +e7SZNlSdNj4LdDvaJ9t874QQps3TGXNn+vxlJ1iTHToecxW+4RqIie/J1HaPGoOr/5y
         65YDUYTLxM2IJ7d2SYYOYs3o4wkLojrtEeNFiWBc90/dDVVeGtSrqp88f0/hKHYNTXvb
         +NpQ==
X-Gm-Message-State: AOJu0YyDcyT0qnQx6F4gm/PzdQhCMxxSSvUfnSqOBip0uOwg4rqtu0nm
	xnI44d4clUPfj8uDz6QX9P1m5e4rb5HhLLlNPV0SEgIVzCDnvuyPOnbp
X-Gm-Gg: AeBDiesDYoD2oafSAr5JM2JuWpaiBzbPmq9yBzrqnX34Bdbr1Jf7XEaTYFWbevQL9rj
	HsmjK55LzI+K5L1v+gIabkbJHjFrWcePKebSqNl2VclZSQvnSJZGDygcgR7F7flh9NB0XCG97V6
	asG+SVqF0BznQV1WqPd9Ye3XrNve7efDJu9rI+4Lo88UHMfhlw/LHegyv54wxyHYqDHYFF5TXoU
	a4IQ3sQckaswSB3FSmnzaLr0UE8WvwulMrMcy7aAQpFgC3tSNBo7p0Vcl3u/4MaIdgveAbL+tdA
	1GnACWlH5yyOjV0EHAZBH7ZSaRo+cTIRNp0Kjk348DjheCqhTfYrCpt/X84EP9m2VAl/aevUD6f
	s4lQUuhhlau7uPFWeX1MgbIKASVSsunZa7XBdLWIUBR/1/ANL4tmb0ZrxMYP8+srixLLGsjJXM5
	dTIvaz3H/o8H+Uyujch3TVz0QDsJngzqdBX+aB5fFm08JoWC8ws7FNDTQ6q+5sv/2khdpRkPIuy
	zU=
X-Received: by 2002:a05:7300:e888:b0:2d8:b814:29af with SMTP id 5a478bee46e88-2ed3c4d5242mr2746844eec.3.1777610455365;
        Thu, 30 Apr 2026 21:40:55 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:4372:f619:5d87:d4e4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3889d611sm3984305eec.1.2026.04.30.21.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 21:40:54 -0700 (PDT)
Date: Thu, 30 Apr 2026 21:40:52 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Dmitriy Zharov <contact@zharov.dev>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: xpad - add support for ASUS ROG RAIKIRI II
Message-ID: <afQuzuhA0OpNssk0@google.com>
References: <20260430183522.122151-1-contact@zharov.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430183522.122151-1-contact@zharov.dev>

On Thu, Apr 30, 2026 at 10:35:22PM +0400, Dmitriy Zharov wrote:
> Add the VID/PIDs for the ASUS ROG RAIKIRI II controller to xpad_device
> and the VID to xpad_table. The controller has a physical PC/XBOX toggle
> which switches between XBOX360 and XBOXONE protocols.
> 
> Signed-off-by: Dmitriy Zharov <contact@zharov.dev>

Applied, thank you.

-- 
Dmitry
