From: Jean Delvare <khali@linux-fr.org>
Subject: Ever-increasing serio device number
Date: Thu, 21 Jun 2007 23:00:40 +0200
Message-ID: <20070621230040.79fe959d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi Dmitry, hi all,

While developing my i2c-taos-evm driver [1], I noticed that my device
was getting a new serio device number each time I cycled my driver. It
started as serio2, and after an afternoon of testing, it was serio19.
I'm curious, is this intended? I expected freed numbers to be reused,
as i2c does.

If this isn't supposed to happen, would this be a bug in the serio
driver, or in my driver (maybe not releasing some resource properly)?

Thanks.

[1] http://lists.lm-sensors.org/pipermail/i2c/2007-June/001508.html

-- 
Jean Delvare
