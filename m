From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: HID-sensor(-hub.c) and device IDs
Date: Thu, 6 Dec 2012 15:32:12 +0100
Message-ID: <20121206143212.GA610@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b31.telenor.se ([213.150.131.20]:56736 "EHLO
	smtprelay-b31.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423543Ab2LFOaZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Dec 2012 09:30:25 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Holler <holler@ahsoftware.de>
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org

Hi Alexander,

> I think the first step would be to identify devices usable by
> hid-sensor-hub, sensor_hub_check_for_sensor_page() looks like the
> way to go, at least for the current state of the hid-sensor-framework.

If you can get the gist of that function into hid_scan_usage(), you should be able to drop both the list in hid-core.c and the list in hid-sensor-hub.c

Henrik
