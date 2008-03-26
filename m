From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: [PATCH 1/1] Input/Joystick Driver: add support AD7142 joystick driver
Date: Wed, 26 Mar 2008 10:36:30 -0400
Message-ID: <8bd0f97a0803260736v58c11f8g8a5f740c62891174@mail.gmail.com>
References: <1206579622-21915-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:9748 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbYCZOgb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Mar 2008 10:36:31 -0400
Received: by rv-out-0910.google.com with SMTP id k20so2057926rvb.1
        for <linux-input@vger.kernel.org>; Wed, 26 Mar 2008 07:36:30 -0700 (PDT)
In-Reply-To: <1206579622-21915-1-git-send-email-cooloney@kernel.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bryan Wu <cooloney@kernel.org>
Cc: dmitry.torokhov@gmail.com, khali@linux-fr.org, linux-input@vger.kernel.org, i2c@lm-sensors.org, linux-kernel@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, Bryan Wu <bryan.wu@analog.com>

On Wed, Mar 26, 2008 at 9:00 PM, Bryan Wu <cooloney@kernel.org> wrote:
>  +config JOYSTICK_AD7142
>  +       tristate "Analog Devices AD7142 Joystick support"
>  +       depends on BLACKFIN && I2C
>  +       ---help---
>  +         Say Y here if you want to support an AD7142 joystick

since you're going to send another patch anyways ;), this kconfig text
could use a line telling you the module name if built as a module.
-mike
