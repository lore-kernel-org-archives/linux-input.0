From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 1/2] HID: wacom: Add WACOM_DEVICETYPE_DIRECT for Cintiqs
 and similar
Date: Mon, 11 Jul 2016 20:18:43 +0200
Message-ID: <1468261123.2277.62.camel@hadess.net>
References: <20160711180711.17537-1-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:49358 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737AbcGKSSu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jul 2016 14:18:50 -0400
In-Reply-To: <20160711180711.17537-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>, linux-input@vger.kernel.org
Cc: Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Mon, 2016-07-11 at 11:07 -0700, Jason Gerecke wrote:
> "Direct" input deviecs like Cintiqs and Tablet PCs set the
> INPUT_PROP_DIRECT

"devices"

> property to notify userspace that the sensor and screen are
> overlayed. This

"overlaid"

The huge "if" is quite horrible, FWIW.
