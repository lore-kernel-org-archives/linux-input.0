Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B414434FF59
	for <linux-input@vger.kernel.org>; Sun,  5 Apr 2026 05:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775367400; cv=none; b=qZSEZC+ioQ5lWxoewCxffR15psOeckdjcpzLXV2QTxv1ffio3YZyPj4bAFwrG80t3PhtJsvSDwQus58Ey77soGBne7VgOqDA8eTlNtlqH/1LzfDPG5dqcxriUJKw2AHS9kQ1FzMlKqfGRvblrQxZQBWe8v6QHgXyko2+pZc6j0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775367400; c=relaxed/simple;
	bh=U4xYPtxKjPLZKJHjFjMhjMkqGx8NjsKOTpcMyJkBsZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRV2uG4uhQMT+G5hYckmMkN87zGxemL8vOTGO/n9AB7dghYc4IZY7IKCXeRIlBrPIOEBLUnxI+TBZzoqE7G8xJK7QJ4+ka5Hr8orhMlj9nDmDsb7qMXNrpzSGjwmKmRKfDWb/uNyJ9/Za4+eGl0EwOZfZeuYDl5NxjEe7Ve+PLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lgQLvcJI; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lgQLvcJI"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ab39b111b9so12649875ad.1
        for <linux-input@vger.kernel.org>; Sat, 04 Apr 2026 22:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775367397; x=1775972197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AQYIFFo7JocmmrV6j1BI0XIUpCFCLQ0FZC8idpT8bo=;
        b=lgQLvcJIvbj2Zczm7TQbMSLd6zec9BhL3FtGWtWW+/wCZlye44gVJX/Z5W3a+jKGZZ
         pPb2hfoqMB9wQn9R+t1K2H4UfhkUf2S3et5tnIUHEFRwdUzxkPWS9WZ1OSjtjQ9k1HpM
         X+UC17c/6hQlDr+hu5RDbWc2rKUSEn4XPoPuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775367397; x=1775972197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1AQYIFFo7JocmmrV6j1BI0XIUpCFCLQ0FZC8idpT8bo=;
        b=HAV5EuN9oDXJtJGlXzHge1XOZrbMo8+Xy/V4nBxfLolZaGEl1+TItxNY/m5u69elYx
         RQYpGOmQlN2Yqv6W0kBwhulkZ+1SV1KEbHfNn/YwuJ6aaD0cdJ4AB9EiuUlGvS7BPkIo
         KHuoUTeUC+nsbiu2AblKwzdch7k4hi/FHEKz48SuCyzve9c5s8j2XzWFUsDnCdvp6Yeu
         PIJLE/weZ5KzBbGXUgRcZnAoYVJyMGyCt22wMUBBjK8Kb0nCvAq/79kpsL4mAegHGQqq
         BxCiazfzxtWBtCxi3ScoXMbr56OEJQaT5G+vmHtAfffMtcy2my9cHjxWuRB9S60KRir1
         xoyA==
X-Forwarded-Encrypted: i=1; AJvYcCW725Mmuz/FbBgmHASc8n9pc+UuA3x8Qk7UxQxR0iI8Y2q58e4evAcj6s+lOF20y+8Q3veLJGQMasZcFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeO3irQt7Q3kkPDtzhu4sd0smRv7wOud6cf+eCtbhw3nJfPEwx
	GXnSkd11nBsYoujHMtLiKzG5kRs0llEk9SCLGwihKfEhHQ9j+WL//l4NNgnhJuAzEf9dWBh/xUo
	PSTM=
X-Gm-Gg: AeBDieuv3yC/2lH6Jp13ouhOWlLo71EUbPBPdZsabvxrwq/y+S4SrDvFOlBW8SIfShs
	BVfOyqvM2TEhl3Va4xdSDClUH3jMXRUPe4MRrioo3luJ7jQg6ay8GBfIE4hEY5A3n9d0wPNZyZY
	or5weFJeIYZnAXq2oetzb0IXM+FDhmN5+Jx/dbtsp3Apl1LeiwdBM5N22/ZBL7jInXHWPNLfMJx
	PdVtin9eqvh3B5iMwA6FnUYSD4/9YuB1LgVJZaKmowhttw+QLnMa9blmpAXHnzszARDUJQAS8sg
	OqJHVv+6t3OzQVJ+KsYzhhXQ52QD6bhcB0YCbxwx81+DUrNTr0SlYkCf21rcUERzqV70ezoBBQI
	ysNBUrqB+DX3T+zSEgesYUWnLUQ2AZh7pRXoeKZLUyYES+zjzjiMhlSdvqrHl7GOqJGKWnQKg+J
	rAE3g5orPqv8GlhvTo+cq89jh+dGJfCYEDTQXy29sy9T8H0wOrdYT+jA==
X-Received: by 2002:a17:902:ce06:b0:2ae:c5fc:b2ea with SMTP id d9443c01a7336-2b28176a398mr77904995ad.30.1775367397593;
        Sat, 04 Apr 2026 22:36:37 -0700 (PDT)
Received: from localhost (3.8.125.34.bc.googleusercontent.com. [34.125.8.3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2b2749bd774sm102579305ad.70.2026.04.04.22.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 22:36:37 -0700 (PDT)
From: Henry Barnor <hbarnor@chromium.org>
To: dmitry.torokhov@gmail.com
Cc: hbarnor@chromium.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] Input: atkbd - skip cleanup when used as a wakeup source
Date: Sat,  4 Apr 2026 22:36:31 -0700
Message-ID: <20260405053631.3404690-1-hbarnor@chromium.org>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To: <acrwy_Y6QMapp5fw@google.com>
References: <acrwy_Y6QMapp5fw@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dmitry,

> We unfortunately need to support devices much older than that, so we can
> not be sure that this change is safe. Historically there we a lot of
> instances where systems were unhappy if we attempted to enter shutdown
> or suspend paths with devices in state other than freshly reset.

Thanks for the feedback and the context on legacy hardware risks. That makes sense. 

I will explore handling this within the Android system layer instead.

Thanks.
