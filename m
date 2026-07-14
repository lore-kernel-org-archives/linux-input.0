Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8906126B08F
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 00:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783990229; cv=none; b=XwLCmT8HlL4f9JMIuF+oHIvf2pySaDLIUdlpDCN79k9H/3RsE0zRvGxAGMBpqlmm7LnfqijiXN9j7ILHVfDwYHAIn0kAKFS56tgDmNg4AthVls725sxQro3auXyYQQ8eN6RzXSukDLjSonaSE2YwogQX+UNUTz3bls3g1lg/wFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783990229; c=relaxed/simple;
	bh=plDsVmvzslVKcZiR15sqtnvWu68bOdQTPFW26Yt9UOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEkU4U8qeBPpymbbjdNw4Nt3Flzvwb9CFsxvehVeopjJqrslity2ZFDtzECcgsGUEye6Xflz3dtyfNk4zT3JSEI1UnkTUGKW0FXGMFsISc5QhPsfDPa9AlZH6qc5KvPUbA1hgkhH89WEQMA7z7iTmrE8VtQLoW7pHts9xpEzjR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rhRDYLOh; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhRDYLOh"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aec139da7eso407733e87.1
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 17:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783990227; x=1784595027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=plDsVmvzslVKcZiR15sqtnvWu68bOdQTPFW26Yt9UOE=;
        b=rhRDYLOhkgfh9eds3MijORtqEx7xIHZfJBDeroTGC+3mI+Eoa1NeuBTSmuGHk6HtJq
         234iFhjrJsMc0hUi46W23lVGX1iWB6vEgjgJ9UlhV980NidphS0uTlq2AUQXOO6u9a7f
         2bhAj1Rhc1PjHMnyzn6uAo6MUjG2NgQp3yJFGt+iGsNT6ZD3y9GIm97hiSx/L7ykcs0Y
         gsPwyOKqAPsX1MO2QdAOKAvYTsBwwsMqkCCxYOhTF8BUFyV498rZrgI3JpIAt4poezwy
         xxdwN7uJWsjzRmXU7OeQ2T5S5gbZ1G7jdj2CWYrMzF4kE6fX5CmNhnAmeS0B7g3tGW4t
         qhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783990227; x=1784595027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=plDsVmvzslVKcZiR15sqtnvWu68bOdQTPFW26Yt9UOE=;
        b=b0N0bVnHY2IYt+8FpgnJId/HTjMGu9q5jzVgOCvav6xVVu+XWLQnax9N8LhReZKMZc
         26qYklKAIG5xknfZU0oMqWYaqphp3LMTMM/TY9tzrKY8qfER8F3JN+6j/dbIIpX6CwGm
         ZogPeEuLQI3K1eTpS8Zehz9Wjt+CDt/ui0okGWxJk0XFObKkp15KpmJyur09NALGnQor
         hDVh6U9MAt/KdPKWr415PD9g2RCTn9zPK2p8TAXoLHvsTdtxRFTe8kMD9EuKvSsVoVY+
         acOH+NhbaVL7xkkw1ScbdsqqDwpXdO0dcDSqzhXcca5zaU3kJhyfoEuGKIbFEnKSnBVE
         XZnA==
X-Forwarded-Encrypted: i=1; AHgh+RqH+hNJ+CQWeLDqoNxKh+RkXlkaU+PLes0+6JYKFUfEq9a5nX27g9pfLXvADIuXByAuyK9FnGEtB6nu5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxiPBTaSkd7qQY4rJmBBtqFbsGe8rD8al3eNpqdliFCNjI39KcC
	oNSgfNr2Ln6fzNtyY02CMY8P3sEfHneXiVMiDXtzDb69vFBY+X7CdZg6
X-Gm-Gg: AfdE7clWNs2LayvNWffYECH6gaX/89rRPzXw49oF+0JRGUhWotSNSqxutmlpv/+WrGv
	OfWSCuHXo17NaoiEf4wx2P+byffBKPL7JUog8c8JQAmUBHmqfFvdhC4PMq1eZgFXjhGB8PZABHv
	oAPdW7Knzy5+uXOrjkIhPag3oRJgpL5nsUJoblNh1uLj3T1VyLlWrrv8T2UbrkOX4mnHayBC07G
	DtrMx4hyhT7uKt6kErsN1hK+r0SmEPbxAlB1coegzZMzGzTd/IrFAsyiO51HodhouTnRQI39/jA
	X/Hb+W/pZN5QyxaAk4x44r2qfhuiafnDNI5qoDBBNAKMruuvrH4fRDYgN7JtE9QYr1y3hj8db7H
	ykI5ft3FkFBbAFKMt4Zypz7AX1BdwZjj7G/ZEcT7jYvBqJ+LZLXmLg2ZYH3p12w3MQWOcWdJX0A
	pepto05QELZ5nUDFNP63MKzkgKmfPAPIe1iayUWceqdAoY
X-Received: by 2002:a05:6512:1418:b0:5aa:62df:cd0f with SMTP id 2adb3069b0e04-5b023d02863mr1994653e87.2.1783990226529;
        Mon, 13 Jul 2026 17:50:26 -0700 (PDT)
Received: from fedora (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01caa60e4sm3198597e87.60.2026.07.13.17.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 17:50:24 -0700 (PDT)
From: =?UTF-8?q?Erik=20H=C3=A5kansson?= <erikhakan@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org
Subject: Re: [PATCH v2 1/1] HID: logitech: add Bolt receiver support for Logitech HID++ devices
Date: Tue, 14 Jul 2026 02:50:22 +0200
Message-ID: <20260714005022.472109-1-erikhakan@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713201201.391538-2-erikhakan@gmail.com>
References: <20260713201201.391538-2-erikhakan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Thanks for the review. I don't know if anyone reads replies to the bot
review, but I'll reply just in case.

This looks like a pre-existing teardown ordering issue in
hid-logitech-dj. The Bolt unpair path follows the same kfifo_in() +
schedule_work() pattern already used by the existing DJ/HID++ notification
paths.

I agree that fixing the remove ordering may be worthwhile, but I think it
should be handled as a separate patch because it affects all receiver
types, not only Bolt.

Regards,
Erik
