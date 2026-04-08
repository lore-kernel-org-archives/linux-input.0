Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C78C70830
	for <linux-input@vger.kernel.org>; Wed,  8 Apr 2026 05:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775624681; cv=pass; b=EfLS3CtVEFtCh0IrVtZ1C0gDEP1CoWWgZ6GgxXTCEzmUzzf52QgLb8VkLxyY6+nhmGGM6boUR9eWKMg+XyhbWvSxMfbedCT0afdgHUqzy0iMyPpmEGUgDohms2PxH1adnVMGeDAKCSV1ewCjSKEH1WSYbWWjA8o4zh6IPAYDHtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775624681; c=relaxed/simple;
	bh=VD0qh+RFQUSHzBgUqIzPvuk0eeELe6OUOVMSLF+bvos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4eP7SPt1nhnsKIHbXiOKbhQ8HMWQmqv2bOJg5qdNl8h6trYqcdGXbNm5ZmGPnJUaYAo5mvDMCX/d2sqfCCXbdDSOhMQsIcKolZFziQQabGewK1iFWV4YqiPcFMliUAt3yXGS/5SducnHCB1Lw5Ui/RvaLs4HKWoBe3PltIEjlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0/Ctqqx; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0/Ctqqx"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38a01c80c34so41996761fa.0
        for <linux-input@vger.kernel.org>; Tue, 07 Apr 2026 22:04:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775624678; cv=none;
        d=google.com; s=arc-20240605;
        b=jIjhwibTx7anPrXvWB23PAym5hgVBmyCXq1iNDsyAHFtrKf7w4WKF1XQZyDqW2ygbw
         ntYTXLeL6KvEqtc7A93AuXS2EVMd4W+JFhQL8y85D5foQN30DE+Dbhs5fpOoMNMD1tTg
         644bb+tgF4G0aci+YM/RfxC4hof7qgndzHsktQLOl26N2UVdM9/Pyash9rXv2RMAVLBs
         q/5e4+YulQDVSPsl/ImPdiHgmHqE+ggBYk73IEcCoXJr2pi16ed419mNZ16wcQov9SpV
         pcDjhmBMNQEazj0/mlgznIOUp7Ao5j5StUcpwJEmLzz8wUTiLsXOyoe7tAsRjnK6Xrnq
         lupQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VD0qh+RFQUSHzBgUqIzPvuk0eeELe6OUOVMSLF+bvos=;
        fh=dgCZxwFkNPA+JqH10lSfG/+YCfuBcsOjF3ZBWPoE8t8=;
        b=dW5MXwSw5V+lT+H4/EiEm3tR1+30UdGD+pxKBB0W3698F11bYm16T6iqWWHYKn+Udf
         DI/bl+YBjMA7E7o1ongpCBGEsIbc7ftzc2rDsBZfQ3a9coLKvWcK18fwyn09x4syeL2+
         RP1jE7lGAaG5qV4QWJIsk/4y0U/8kkZChJL76KCkAdAGnygD5irlfzS9gHomiREnXjFH
         7ovOcdZmW60A3H1Yb1Jc+6sV4bUBSAi+fgeUMMsmV/pQyYeZQdzkNPjAcF45A8SGkU9a
         WmefbP81e/XI2DmX7xN9TYiwuJg5AutvIKbV+e+pFhsh83KnR+Kxyx0smSkdUNEi/NRm
         zbNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775624678; x=1776229478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VD0qh+RFQUSHzBgUqIzPvuk0eeELe6OUOVMSLF+bvos=;
        b=l0/Ctqqx8nqv60h7AuTcmIJm3xFDZeh3w6GbBQRiDN3MgJ5i/rQJ7zP0Wcy1VEPLI9
         WZDc57RKjSmeykbNbGJB3dqsIb2ULmNLBDETLrNvdAWBv7inVZjOXPuXjU6WVozutxHH
         sZSucOnxzwp8+TEJ8bodK2PatG8dCeEA9xlLnmpC8JerFRxTC6czichPtNI6sr2inUoO
         kVecooxVt4UgCbMK7yLPPqmYkkZTmEvk5CSi6pRmgEm0u/83Zoesfv7UYmUqXZVbP4XA
         F4mvnWZ5gSWp9aSSj1kPwsHnt6J4bdn6fZfMXvCoa3WJLQvyjrccWzSV9yWIZGcYzXMm
         MICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775624678; x=1776229478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VD0qh+RFQUSHzBgUqIzPvuk0eeELe6OUOVMSLF+bvos=;
        b=GaMWTSy7RPOlUj71/S+3QrHCvrx4l7V/VSVghxwNtPufTytCfqzc7cv0DM4SMeR9r2
         PizhhHCpskVo8beKK1od0E53cvRK9SLsvKz4LhkJH0P4hxYbMLC2bU10n9KDJ/LSzx+R
         31wS6YjYp3e0QL/spI4co0QX+IcYMENINdlYV07o0q+ZNxRvcgh9cDqxGheUoAJSdRi0
         rSQOMtcKh6thpt7AzpwMQPdawP7b5kzHXE6bndzq3NLRcDz6rLfaazWWz1GoWlyfXHe7
         UIZem15H/5on+1vGsUOUpUH+I5TBy5WOabn4wS+m57upUft3Trx9zOAzMVdt4MG97lp6
         E6MA==
X-Forwarded-Encrypted: i=1; AJvYcCX+GSIG2j0KrYOdU/BvO3nox3EIe4kj8Nj8gLnixjyK0YJaH8tQKCnQWJi7PAN2C85C/7eOl5NxttJBSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYxs0z97dNughSl0aENsWrC/7qTWvtCxesnNooEnWarihXl9wJ
	+lR7lhSELtcwL7uXqRJfVP2XTsiEg7fXDxFI6W1oV4Wq/dqeYmnU0wCDvTHWpH5NVWEXFO/HfzJ
	Ny8hq2H73pcMA7gRz7hLkZGpL8yogHjo=
X-Gm-Gg: AeBDies99y9F25Kkowcc5QAYZ6q2mkO+MFmcCKcmVOXxyB/s7u2txaaL7s3Z8Gu7K5V
	dTdZFd4SCbzRVNa8H7vtystaJ7F4lBS23UTYIVnu2Fu2pPBJPgHOy+evl9PZ1sPzwOdiggpGQu3
	TjDNK5o89j9/WE4ztY+mDFr84h/FpWjyWSiiJUIat0TL8QMQGB5Nz+61lz9gm5s7nRBN9rfYrI+
	pvEG9ywyZw3bf0mVFUJsDNRroERIPViwFBGBhBTUrrGc6/bCzuQlU7zivM8Q981sfz5XXV271xA
	5HKbrTn2o78uUVg4Fd+TMoh8ar6ABusx5HeXEiQBq93JDzV997k6K/jkRYCCDF0HrJahQWXTJti
	vQpUx6fCqktY=
X-Received: by 2002:a2e:bc84:0:b0:38d:e220:8dc2 with SMTP id
 38308e7fff4ca-38de2209a3fmr51723481fa.20.1775624678298; Tue, 07 Apr 2026
 22:04:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404083928.489966-3-sanjay.govind9@gmail.com>
 <adSJp5U47g1JnImj@google.com> <CALQgdA0oYzWqFtyG2eZKgwKr-QLYz5dLbsFbpY8qDrpxK7vj8Q@mail.gmail.com>
 <CALQgdA0UpJb7Lztkts3LrFtWrAP3V3CivFv3NKJDFg1VY_q_0A@mail.gmail.com> <adXe452989A6k2PJ@google.com>
In-Reply-To: <adXe452989A6k2PJ@google.com>
From: Sanjay Govind <sanjay.govind9@gmail.com>
Date: Wed, 8 Apr 2026 17:04:25 +1200
X-Gm-Features: AQROBzCbDXK4IlLEJhSOy65YBAmmDG8VLVROtjTn3Q1vbjprO3i7GNLfFyE66dY
Message-ID: <CALQgdA04mczQoJ4HyjSwgeXMHwLT+Rv0AEoArpwBohzL9oa1nw@mail.gmail.com>
Subject: Re: [PATCH v2] xpad: Overhaul device data for wireless devices
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Vicki Pfau <vi@endrift.com>, Nilton Perim Neto <niltonperimneto@gmail.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Antheas Kapenekakis <lkml@antheas.dev>, 
	"Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 4:52=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> I think you'd have to spin up your own instance for that...

makes sense
