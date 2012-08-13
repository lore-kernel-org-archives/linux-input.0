From: "Aguirre Rodriguez, Sergio A" <sergio.a.aguirre.rodriguez@intel.com>
Subject: [Query] Best place inside kernel for mobile sensors?
Date: Mon, 13 Aug 2012 21:29:47 +0000
Message-ID: <93C0B00A428C6E4EA1CA440678FE8AF59A74F8@FMSMSX101.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46565 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752615Ab2HMV3s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Aug 2012 17:29:48 -0400
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi all,

I'm pretty new to the input device drivers, and trying to understand the right place for the following sensor types:

- Accelerometer
- Gyroscope
- Barometer

Would it be appropriate to have them all under drivers/input/misc?

Thanks in advance for any response, and sorry if this is something pretty basic. Please bear with me.

Regards,
Sergio
