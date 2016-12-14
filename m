From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Issue in applying patch [hid-sensor-hub: clear memory to avoid
 random data]
Date: Wed, 14 Dec 2016 10:27:17 -0800
Message-ID: <1481740037.3319.3.camel@linux.intel.com>
References: <1480546127-3539-1-git-send-email-linux@rasmusvillemoes.dk>
         <alpine.LNX.2.00.1612021504170.29400@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60307 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752117AbcLNS2G (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Dec 2016 13:28:06 -0500
In-Reply-To: <alpine.LNX.2.00.1612021504170.29400@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

Hi Jiri,

As per the comment here, it seems that you applied v4 version of patch.

https://patchwork.kernel.org/patch/9428715/

But when I look at the upstream kernel, the very first version of the
patch was applied, which was wrong.

Basically the change should be in sensor_hub_get_feature() not in
sensor_hub_set_feature().
Otherwise it breaks sensor functionality.

How should we handle this?


Thanks,
Srinivas
