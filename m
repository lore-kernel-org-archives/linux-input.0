Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D314374A19
	for <linux-input@vger.kernel.org>; Sat, 26 Sep 2026 09:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790413664; cv=pass; b=XqIdTPnXmJyOLLJs6MZXq/rcoYHOoUNzRGewzLexB/cnH9eE6FmLD/Aahel6+y+1IqzDJsqfpsn2KmvEtPSpr8YGMq2k8opEAB9bhzUL+Z78iZPzcODBA0Ye2RfTAUi933DX20PzSCEA5WowpzjONtjJMOPzalUQIhF3EXpbHps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790413664; c=relaxed/simple;
	bh=KdtRAVAgWV/Pdj8tUYG611t8Xj72fHiG9bT/8OYtB98=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IfskINF8E6zgCxmotxZ5PCEfcDDvr/MtD7bj8TNB6Z9Az6l8R1g9G6HdCQv+24IWipWZbJQ/cwgKhQqlZXHwfhJGNiGN9utMhY8ULJRSkyp1oDgMe6XN2nsyQBNO4F5Ui7FVlugj2oftU/V3FTBvvOhTlpXJRXcgtB9E1ufJ2QE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ig2kdn6M; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ig2kdn6M"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6a605c198fdso2529345a12.2
        for <linux-input@vger.kernel.org>; Sat, 26 Sep 2026 02:07:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790413661; cv=none;
        d=google.com; s=arc-20260327;
        b=Yg9lWzKZ4x/P124gOsVnVlD6OgN43g8idIlo3BXQoT+PXhCMvFPBJd/CsVbCjpTm1Z
         Gw6Z2fTlkViMSiwypbIMxraS8TJuLYmZUxKbDVMe5g8ECFpKYvy0Md582RBfK2B+AP+n
         TxOOC9GQnZHcvpso6ra1EQbd+hzYEIC8dKoD3smUx4eIlZCBOeE2RkPxjbTlWWIQiMo8
         KMSjIPnHM79Axy5mQMXCmua5H8wIo2XZTgiISLaqUMeKpjVzBGTJ30hByy8IvqAHxJkO
         eHUIYG/eENnyRLIqEiNGp9OAK9vPd0rEhBxabbU13fbuYSyd5/eMsSsUC83jgR2TcS2W
         wVzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=lSM6HQxBAejI+851l2sK3/r06BUvqq2rhqSu3Q2o8BE=;
        fh=KzaLzWbIt4n4bcIhlPKUVYS40rFKMGxLaNPBAuP8yxs=;
        b=EDHNhkXxsAgY2nTlNqsaCLlXeOrLn6bJhh9E1z8CascbuAVygwPb8f7I6f4fjWuChS
         3uHA1+D//rWss1DAR7XAhuzgo3ulcWsCDKoSHoTVUYPNUWmkG3662Tak4cc8xUWfrO7k
         2C1LZ1p+iAF5aUlK2zxqqJoaysmeEoZah2hIGIal8ghTeU2th8Md1qNNB3+fnX6jZwZf
         ihYEbpTVldfAJvRO5FlKCi7Fmlu5Lb6rhNzx0MGJHIU91sjZxofCgXW+d0Ri7Y53YcHT
         uPLXjPMswt83sfThL49L/OXeg+4+O2YA40rrLPNr8QcIrS4FWZXdzvSDQBPwCfL9/kZz
         xOVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790413661; x=1791018461; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lSM6HQxBAejI+851l2sK3/r06BUvqq2rhqSu3Q2o8BE=;
        b=Ig2kdn6M+DssXihFMolYAzOvBKnE/GNWcziM7S61VN9A3g+UeouFrR126g0hVlCR8o
         iI4yytyehSv8MHnuePqbe61bSJlxXnU3u8SpO1oVl1d7Bc3KMMcjYsIdsj707EKvSx08
         avwRfxGRvCSO9qNTBY1hODAE75RTAmR7KYfxbKptTIDCyYk233LYBndQsrs/Zk+zUDAK
         Lc6qQ0BTrxRU83QSZa/KmOEBRMzGinLawfXRZrA9KytRRQI21W7R2h/jpP6aPbYJ5ycy
         V1+RlmfWdUvvZO79RGTQwWaMBkSyCcyjgMuPBydu9f5USwrxxEteLVwsdUC1ac8J0WLQ
         uJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790413661; x=1791018461;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lSM6HQxBAejI+851l2sK3/r06BUvqq2rhqSu3Q2o8BE=;
        b=M9if8Vj/Ln6GT4i/Qt1mukz6nRq4MypGu13OzDmvJVm0BwtOj97FhCCH4dGD+jjTe8
         pc2yiI4QI7FEa0n1Su1iw93BG/2YKMlX8+EwKCR+2IJaU8kDlvWMs8DlvCW2GqRkAhZb
         c4YrR3VvO0csj4C7fduc0W5SraDDoD7Vgi9vo5VMq0r8RWzYJaxivH9MdhPP6CXhJsam
         fqZ7HBdS9YPqGjdoTvbuQ6WvQVENyY0r43J0uoStRK5PM428oyEXpXKoiylTD2RZaAkR
         ChBWDOz3UbKlTD/IV+Ewp1vbp1svcsN+u5/EUK860RWOc+Lu3KlEucA+koXEBLhL86zC
         amSg==
X-Gm-Message-State: AFuF++n0/9LB6td1tFwl8G9ZHOzqJccDDVHBRn3D9xxMpxK3ViUunNC0
	plE+2sV3lP3totDOa2qmZ/1/pMDnl7j4dKY9hGq7ga7dM0pYdjVwbzbQQ/Y12csSXCu1oZiNUBn
	Ehg5pSmnNetWcDlGnLB9GLMet+97PG28bIEvWb20=
X-Gm-Gg: AYBFou31/02b2Q/n8w4rZOknAY1K7nmn5/7cS6T8DTn5HNS4dVmVOkkPHUHiN1DisEj
	i+6o4//gfVDJ4PjeZFwii383Se6yKjTdj8fkeXQp/k+d4aj6IUkWYf1eNcgpYQXlK8KnuVpXcr1
	b4+REBF6AK2FPWm0cmVHt0kSKUV0kr4qRP8//FvLTMdGTwgzsXKRkQBuo0d0P/2W4TgbxUB7L3b
	sO9sAdFEJpTY/fpUp4DPi5wF5sJ2zvVEAVQ8V5W2oNVyiNIY7f+Ap2OrzRGi3GVVZM5+H8FCMBF
	3mMWlMAw1lOKmkzIy/zQq98WD03vHnSFu7ETLvaAlCpdN2vaJdasvvk=
X-Received: by 2002:a05:6402:1f04:b0:6a9:dc6a:689c with SMTP id
 4fb4d7f45d1cf-6aac8f54606mr7242930a12.22.1790413661183; Sat, 26 Sep 2026
 02:07:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rayr Rayr <rayrishere@gmail.com>
Date: Sat, 26 Sep 2026 12:07:29 +0300
X-Gm-Features: AclHuK_hvtoJxFCHO4xgfptPk_y5uksrADmiGYPQQzyLfmDgy4lBRqghlixEggY
Message-ID: <CAP4AxaFCjxpikg-i8tUKgwWWV89MaSWBFZmUMoDzueaf+anNxw@mail.gmail.com>
Subject: 
To: srinivas.pandruvada@linux.intel.com
Cc: linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Srinivas,

I am writing to report hardware verification findings regarding the Intel
Integrated Sensor Hub (ISH) on the HP OmniBook X Flip 14-fm0xxx series
(Intel Lunar Lake) running Linux.

Hardware details:
- Model: HP OmniBook X Flip Laptop 14-fm0xxx (14-fm0023dx, SKU: B5UJ2UA#ABA)
- Platform: Intel Core Ultra 7 256V (Lunar Lake LNL-M)
- BIOS Revision: F.10 (2025-10-22)
- PCI Device: 0000:00:12.0 [8086:a845] (rev 10), Subsystem: [103c:8d9f]

Observed behavior:
With current upstream linux-firmware (including ish_lnlm.bin and
ish_lnlm_12128606_f9751b71.bin.zst / v58.0.7720), the kernel driver
(intel_ish_ipc) fails during boot with:

  intel_ish_ipc 0000:00:12.0: ISH loader: load firmware:
intel/ish/ish_lnlm_12128606.bin
  intel_ish_ipc 0000:00:12.0: ISH loader: cmd 2 failed 10

Testing other newer OEM builds (such as 5.8.0.7726 and 5.8.0.7729) also
fails with status 10 on LOADER_CMD_START due to signature/version
enforcement in the F.10 BIOS CSME enclave.

Resolution:
Inspecting the factory Windows installation DriverStore
(ishheciextensiontemplate.inf_amd64_*) shows that HP configured this
platform with:
- Firmware: ishS_SI_5.8.0.7718.bin
- Size: 645,632 bytes
- ISHG Version: 5.8.0.7718
- MD5: cde0b12d3a68f240c6423a7e93f29409
- SHA-256: 2d9f9bd732bfc80208b50645ff9fc6fdc1b046be71f7d4780ea6858d1676c759

When this binary is provided at the calculated DMI paths:
- Exact: intel/ish/ish_lnlm_12128606_604fc7b4_e4cc03e5_ed8665c2.bin
- Fallback: intel/ish/ish_lnlm_12128606.bin

The ISH coprocessor boots cleanly without error:
- Base Version: 5.8.0.7718
- Project Version: 1.0.0.12584
- Registered IIO devices: gyro_3d, accel_3d, and hinge
- iio-sensor-proxy operates correctly and auto-rotation functions.

DMI fields on this system:
- sys_vendor: "HP" (CRC32: 12128606)
- product_family: "103C_5335M8 HP OmniBook X" (CRC32: 604fc7b4)
- product_name: "HP OmniBook X Flip Laptop 14-fm0xxx" (CRC32: e4cc03e5)
- product_sku: "B5UJ2UA#ABA" (CRC32: ed8665c2)

Would it be possible to include this 5.8.0.7718 firmware release in
upstream linux-firmware for HP systems with this DMI/subsys signature, or
coordinate with HP for an updated upstream submission that avoids the
authentication failure?

Thank you for your time and continued maintenance of the ISH subsystem.

Best regards,
Rayr
