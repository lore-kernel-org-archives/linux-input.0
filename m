Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AE933936F
	for <linux-input@vger.kernel.org>; Sat,  3 Oct 2026 05:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791005323; cv=none; b=swqFYbz4P56/78ChpIHgiRXaY3spBrMbzqaav1mPwlm/+0zDSrLnA8Y7Ki0bbw7kwO2kRZOF3FGHo8MyOjrzQEDw3ZKaJ488Me20lJbzr6x1t7/VvuVwZQriKxqN7MYLwwC4Eg6UPRR9YTC/YnfNbeIOn0icKAItQo3QG6TuCXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791005323; c=relaxed/simple;
	bh=rMm18PsWKRJ+w2UwQq2WnyTOAokNs8pmOrC1sXDDnZM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lSc3CAy0cGvLfnr7cJ4qT1DIv17ysLfcYexm244Z1TSwFX3zsbza3hOfweiOlQ4RKhCVqBpO6upi4EDq80rfvPa5gPwG5XIwXPf3l0RXxUxFcpDgPQC8mYCR0Vji4iBfciduk/cILTdv2kd7/VIblDa/vx7NhCAlTJsc+VN7tfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgC/pG1y; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgC/pG1y"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1419d3416ceso461685c88.0
        for <linux-input@vger.kernel.org>; Fri, 02 Oct 2026 22:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791005322; x=1791610122; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=85FSgDoxRamTD4MOP+biPPbZilpj8nn21c7trAtdX40=;
        b=DgC/pG1yDrwQ4DlQ9lFqRpW2PZbcczzZLjKCwZuBluv/CAbrXqvakQomqTUcWFFPwM
         tn5nzjtaaNy6rP5iTvu57a8Nuh8//8GYEpyxVjOSBak8yu7+BTt9nq3O2Y/In/mmLccO
         UG6aDCrMbBZolZ6bEXK7+wI5vjMBv/ZGVSZ2FbOKK3rddS/2w/1LS4/uFn8Kmcia3mNo
         Byh/WSWNDE4/9ez+FChySO4rF9xbUQxR2QCMSF1z84IoqD9v89MK8kcGk+1OH/d9nm//
         KFtVKkg1J50IXN3IIXGs/Ddfalxx9S88zQ29OoKEh0DdbY3vDiC2zNBTCljCmO3L7uUJ
         +NzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791005322; x=1791610122;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=85FSgDoxRamTD4MOP+biPPbZilpj8nn21c7trAtdX40=;
        b=H7QRiCHLRlUcQ+TXQjNJJWwiksVBeT4MJV3wF0BXJbyt61mxcnPwXZE4q9n71h6g2b
         W7F2LIQDwS943hup6rLuNQ72Ew7Z9lL5KAYL2+oEfEtz1wLNufsGSXORPspDqCqFUTkW
         k13RB983Nd29RXhsA/AT535/OaAI5KDnFNmxWcp2tTnDS2cqtc2CxXC5slohuR5GHNx5
         9Wqzpn3vGOjccHf4fAUyUpETSKXzqBSzjY1/3WrEASN4cJKvj5ISo3FNfPFUyIp7KN7G
         rJNlWxmBJDCdavBXlseyM1M7YLTU0sVYDAo1D3BAlFK/54F7jVuxeSFqeascCpHnh3mg
         3lMA==
X-Forwarded-Encrypted: i=1; AKwUvByU2m2XvQwq2oKOoFL404zS67W/NXjls7x4MH0ZFdS0IElfEHjQIkeCJ6WKH0/cckWU9hCUcRyOmkSkMw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIlMW53RensXJPu7jUtSC45sQYlxKqPfDOkTQsKOZmyxI7BmTI4
	4pc045x/6EzPKrgxNcr3suAEKWnr+vAJBs+KH+Jh7a6x1P+SvHhUAX2c
X-Gm-Gg: AYBFou29Ukw5GSVeRMMFL9Kn497fZ5QqhUTy0djaGS2I45DPfX61kNDBpnQlQ87KBSo
	rzJupypMF1W3rSp4AUiK2HZV0qsmvxjWUdM+cDyo6B3/U0ubSlWT8Dxk4gmeO4L1NinhdgwJ+B2
	s5tFNXQSrmarB8MUNzrKuW6A23MIaBtcuFMYbnu+WcVkMMkotlgOiSHh3/FhYO/3oHsx5oxsJyb
	BTAXVjkZLkOhKzD3T2EYyYtxeHcAhz2sgTUEl51oWNsYAcJKU+WJaboa8JDU2zxcOtLNCIqjP2j
	DSSijH6wfr6Y6mdqKmCQ29dpD5ZAAyBKa7EskpiiLKRETGViX2LvtMsCDvBS55/wIYs7IRI6zqH
	ar/fL6nCdR5EmXeyPsRdr8BHHVu+RiISD23D7hvcLyqUbKWY6/8UzrG/IADJZ343baetdxXHLlE
	+4jWUmx4B/WuYXsH7AlmqIoa8kyTuWu4v/oSbMn0bHCDXzXmtRZesfCZqzwyY3hhIUaYdyI2VqQ
	M31Qd5yXJzg4ClDBaTLfNMlxAVvMQKdNwuFqVaG
X-Received: by 2002:a05:693c:414e:10b0:351:1169:5f19 with SMTP id 5a478bee46e88-35111696d0cmr2165343eec.26.1791005321594;
        Fri, 02 Oct 2026 22:28:41 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:f6b0:90e5:8010:fce8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34ef98d925csm11659146eec.0.2026.10.02.22.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 22:28:40 -0700 (PDT)
Date: Fri, 2 Oct 2026 22:28:38 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v7.3-rc5
Message-ID: <asCSdpnXizdBEOtE@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.3-rc5

to receive updates for the input subsystem. You will get:

- A fix for the Samsung S6SY761 touchscreen driver to power on the
  controller before unmasking interrupts during resume and to re-enable
  touch sensing when the device is open

- Updates to the Synaptics touchpad driver to enable SMBus/RMI4 mode on
  Lenovo ThinkPad T490 and restrict the ThinkPad T440p InterTouch
  disable quirk to LEN0036 so that ThinkPad L440 retains SMBus support

- A quirk for the AT keyboard driver (atkbd) to skip keyboard
  deactivation on Lenovo IdeaPad Slim 3 15IWC11 so the internal keyboard
  functions properly

- A DMI quirk for the i8042 controller to disable active multiplexing on
  Fujitsu LIFEBOOK U7410, preventing the internal keyboard and touchpad
  from dying shortly after boot.

Changelog:
---------

David Heidelberg (1):
      Input: s6sy761 - fix resume ordering and restore sensing

Lovekesh Solanki (2):
      Input: synaptics - add LEN205b entry to smbus_pnp_ids for ThinkPad T490
      Input: i8042 - add nomux quirk for Fujitsu LIFEBOOK U7410

Martino Papero (1):
      Input: atkbd - skip deactivate for Lenovo IdeaPad Slim 3 15IWC11

Raphaël Larocque (1):
      Input: synaptics - limit T440p InterTouch quirk to LEN0036

Diffstat:
--------

 drivers/input/keyboard/atkbd.c        |  8 ++++++++
 drivers/input/mouse/synaptics.c       |  7 +++++--
 drivers/input/serio/i8042-acpipnpio.h |  9 +++++++++
 drivers/input/touchscreen/s6sy761.c   | 14 +++++++++++++-
 4 files changed, 35 insertions(+), 3 deletions(-)

Thanks.

-- 
Dmitry
