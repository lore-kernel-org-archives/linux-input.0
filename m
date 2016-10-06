From: Frank Praznik <frank.praznik@gmail.com>
Subject: Re: [PATCH 1/2] HID: sony: Adjust value range for motion sensors
Date: Thu, 6 Oct 2016 10:27:17 -0400
Message-ID: <AB243ECF-9931-4C76-9E54-A9D15E06C3F4@gmail.com>
References: <6BB4B6CF-1DB7-4F90-8D7F-558407E57203@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:34461 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755681AbcJFO1V (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 6 Oct 2016 10:27:21 -0400
Received: by mail-qt0-f170.google.com with SMTP id q7so8608220qtq.1
        for <linux-input@vger.kernel.org>; Thu, 06 Oct 2016 07:27:21 -0700 (PDT)
Received: from ?IPv6:2607:fcc8:9e44:d500:896d:8a7e:b9ec:793d? ([2607:fcc8:9e44:d500:896d:8a7e:b9ec:793d])
        by smtp.gmail.com with ESMTPSA id c193sm5235350qke.22.2016.10.06.07.27.18
        for <linux-input@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Oct 2016 07:27:18 -0700 (PDT)
In-Reply-To: <6BB4B6CF-1DB7-4F90-8D7F-558407E57203@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org


> The motion sensor values are 16-bit, so make the value range match.
> It is hard to reach the upper values, but they can be reached. At
> least the current accelerometer value of 8192 is very easy to pass.
>=20
>=20

Are the gyro values intended to be scaled in any way?  The current =
min/max values were based on the observed maximum extents of the =
controller at rest.  With this change the controller at rest will never =
appear to be turned more than 22.5 degrees in any direction to an =
application which assumes that the logical extents represent the device =
at 90 degrees.

