Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23E737F322
	for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784822156; cv=pass; b=EsCn+mGWX0shO9wPkCngIzPOgUwU0k0rOdtdKzJ6ZFJbCGuUv2s4ojImzA5EaUMCScKXfzyjFBLVbAJ9N4duXYGK0lo03lr+Wuwe5L5Z0U9o6g26d345wn/CefTudG1Kp7S4ELTbijeC5s0+bil4CUwe3b/2amYU3mxN6FngKtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784822156; c=relaxed/simple;
	bh=TviD2TfpUyvALHM/EIRjWbCupkH+Sjjc0vKErzmfC5w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=M5dd430hLQi3WiOFroR5mqhtOGqD5HVLwxIKXVZgbZ0UrbFUjQXahUZwoOoZv2M8Cei6y7ycEj8K0Yc/rR2v6mFgiy/Gftb4vz3FqValpDtBwDn6Gz/HdGKmKyLp0bLAoDB7ntVczn3qtvr8Qqz3sf9OJ3hL+HkG6/SFQx24Hsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5lHJXin; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5lHJXin"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-81e6f2ee60bso4896887b3.1
        for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 08:55:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784822152; cv=none;
        d=google.com; s=arc-20260327;
        b=ZMpi2+426zPjuDpOILlQBBlhugC55djAXsejmDreXfH3Hfnwv4UfGYKAfEBAeogYye
         qdV4bpxDdXfEf2/dpSCsW6LNgLn5396GdCUNGwWEd81ReETM8glyyi4RX+QD/tgGQt3i
         SJ8owQtqOHiwUcd383Pmlo62BcxydVRYtlfqJHWDFKIgboGqbZbRIRJX7OjtlLVRQqwP
         LTxCPY++nSWpIIalcF3kd6acgUVfTZ/9N075xA3sGdOK72NvZ1EbuOWBx/FKE4y6Dx2n
         2JY++Y7Ix3XmwQvz4bhVSjKSKEp5O0Wk5B/TurVFlA+CK7owyLXN5Pvkmdqrf0/R/ser
         kpBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=TviD2TfpUyvALHM/EIRjWbCupkH+Sjjc0vKErzmfC5w=;
        fh=Btgaa7P0WoXIOGDCwPYGmGrzDfRI0PLyoU+UYPBzpvQ=;
        b=UlxOOvqLTdhwsdlN6dq0OBb7dwicWGNqAxdLiSyYdkla5MEceV3g5wRA7/fN/4G4xB
         lfvPB1hfdVCIjtU7WgGD1MRn+42QMjK6apy0u9a6ViB/oF/oIaG6pnQgzzEiz8HkOPPc
         CVYIiCjbjmf2KdFMabZFqa/5CrK6nMH2ogZglXZIoi7vr0hI+h0GZHaNtnuOJlvb1pS+
         KSXnpx8SK6D4gphbw+AnWwUteEnBcWnP+TJuU29BWFSqBPpH4TK1BjbyVTTHgmlny8bo
         maU9HCrx7H6e0P8vKkBlRbwnTbBasEcRcNDJVLxRKlgHQg+S6btF5Y+8LO5lnSI+S5Ww
         nQyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784822152; x=1785426952; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TviD2TfpUyvALHM/EIRjWbCupkH+Sjjc0vKErzmfC5w=;
        b=Y5lHJXin2EGQPz+h5dgA3pvL/9tBC+1wDi/YVS64qlutHNtI38OD2eu4+5lLSQq/4D
         SZDk7WOQ9Zlg20lYXzgYfrNszua2SRWAXJ4P1iv+ezHAWlw1OQXxxHSDRY26gE9aKKv2
         GHRxkrq2rrDbk0vxa33otFLug3Hzjy88R1ClLD56I+yUVTvCOKrhHTZXhgnqxM3SI3jG
         zzwv4KjCly4Sj9vWXwWPZEvyPtL4GSR3hLuZlvKuirnWftc3E4uipOtUAFnBslXHT8x8
         w93EonOLA/t+yl5RnInp/dQ/ogI5uq0erS97Z5j2EQz+dWmlWQ0HhsoFpG1eH65nCUx6
         4Ugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784822152; x=1785426952;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TviD2TfpUyvALHM/EIRjWbCupkH+Sjjc0vKErzmfC5w=;
        b=BJ6SNJJSgAxzfUOlc7Q/ssW3OH+VGBZpr9F18FM8N/p+tzT6YnnotxGIqOiSavehgd
         Ea9Z4Ky0ir6LwaQvQXU7xJ7vzRyAv93LNYDwWQTtC8Nm56I1CPbv0vSdO9yDehpPX1EU
         OWWracXAyrjqf8xMeZe9o5CV2wikFLzOv4foWhetbdBubOdyIF8hE3fiW1LM0Qy/bL2+
         uA39tMSeZv23v0SKIzCSOiQL8p5mEkvcn4d63aQTLm7F2bAnKiHhs2Y0I3WcKjvmklLI
         SWoHKsy9wbsz1yJ8tKjvs9nc0mzob1Rlo36a/sBq+ff1kchZ0vS3hLdCSrFUy9JzVaXr
         DrdQ==
X-Forwarded-Encrypted: i=1; AHgh+RrTAEEdBoyjZXYN6xMwxa+AN78+QKQq04As2qLoeZR9+2dFyGly25VT9Fmj3cM309BIORwuSJNPoXnltg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxatDWcPoGfpwKdOQ5QBNGObV0LYn62v6SbBO/R+A5Zht50b1J5
	Z7tBvJo+vo3qvzXvpji3pthVNCd+SZRHmn3ACkui4QfY9QvHo8n8MIVRAuP1VkQeEvurGoeeSnx
	EU56fYaLkDcxwJtbzZ8lzzox6QmY5j04=
X-Gm-Gg: AR+sD10zJN3Jq1PFVXeoPez+amMtnmrIAPyINYBO6Lv3JiYhs1KuUYbuJ5ios3x5E0y
	RrsGWZAuyi0uCt74qqalgghiMk/kOnPvhBLrjxZqDdokYXss0vJ2/LTQZT72c5tVJIbltQPNhET
	Px2l92fmMUAPZYbHNjaMzjONyWFwVSncX6I4eWf6qE6b+WPtEbgK+nhGH/yOJqob0w+MqpTBi6K
	yyVAd5pbN39RBKAv8zJIN8pmpcpD/Bu7rG6gswK3ZLqanK9MMQK2zWNmqOvt0ZvuDYJk0kLj2wx
	rIP9vfaRHPTpNfTVdPaC
X-Received: by 2002:a05:690c:9988:b0:81e:a56f:844d with SMTP id
 00721157ae682-81f4d674777mr8493697b3.34.1784822152252; Thu, 23 Jul 2026
 08:55:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Seungjin Bae <eeodqql09@gmail.com>
Date: Thu, 23 Jul 2026 11:55:15 -0400
X-Gm-Features: AUfX_myfn2FaMlmkA2LiuJzSjqX_ZEXsJgUtW-kCkzcBZ33Swfp-26sycjak0aI
Message-ID: <CAAsoPpV1WtUsPRtuRHQb8VuCvMHYHG2K-NU-LKGhFL6rWBdZHA@mail.gmail.com>
Subject: [PATCH] Input: ims-pcu - fix heap-buffer-overflow in ims_pcu_process_data()
To: stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Could you please pick up the following mainline commit for all
applicable stable trees?

commit 875115b82c295277b81b6dfee7debc725f44e854
Input: ims-pcu - fix heap-buffer-overflow in ims_pcu_process_data()

This fixes a heap-buffer-overflow in the ims-pcu driver that can be
triggered by a malicious USB device. The missing bounds check on
read_pos lets an attacker overwrite the index and corrupt heap memory,
which can lead to a control-flow hijack.

The commit was merged to mainline without a Cc: stable tag, so it was
not picked up automatically. The bug has been present since the driver
was first introduced, so all stable trees containing the ims-pcu driver
are affected.

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")

Thanks,
Seungjin Bae
