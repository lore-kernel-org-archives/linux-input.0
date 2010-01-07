From: Bastian Blank <bastian@waldi.eu.org>
Subject: [PATCH 0/7] Input: wacom - Setup features via driver info
Date: Thu, 7 Jan 2010 19:25:53 +0100
Message-ID: <20100107182553.GA11236@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wavehammer.waldi.eu.org ([82.139.201.20]:41725 "EHLO
	wavehammer.waldi.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964Ab0AGScP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jan 2010 13:32:15 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Ping Cheng <pingc@wacom.com>

This patchset moves the feature info into the driver info of the usb
device ids.  The wacom driver always needs this info to setup the
device.

Currently the driver uses two synchronized arrays with the standard ids
and the features.  It calculates the index into the features array by
hand and does not check for overflow.  With the ability to add new ids
to the driver, I can instruct the driver to access non-existant features
entries and produce crashes in the uevent core.

Bastian

-- 
I'm a soldier, not a diplomat.  I can only tell the truth.
		-- Kirk, "Errand of Mercy", stardate 3198.9
