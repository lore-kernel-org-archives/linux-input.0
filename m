From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [UPDATED] WM97xx touchscreen drivers
Date: Fri, 18 Jan 2008 16:26:27 +0000
Message-ID: <20080118162627.GA28974@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762852AbYARQ0i@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, Liam Girdwood <liam.girdwood@wolfsonmicro.com>, Rodolfo Giometti <giometti@enneenne.com>, Russell King <rmk@arm.linux.org.uk>, Marc Kleine-Budde <mkl@penugtronix.de>, Ian Molton <spyro@f2s.com>, Vincent Sanders <vince@kyllikki.org>, Andrew Zabolotny <zap@homelink.ru>
List-Id: linux-input@vger.kernel.org

This patch series adds support for the touchscreen controllers provided
by Wolfson Microelectronics WM97xx series chips in both polled and
streaming modes.  It has been updated to reflect feedback since the
submission last week, most substantially in that the Makefile has been
cleaned up and the pxa-wm97xx has been renamed to mainstone-wm97xx to
better reflect how system-specific it is.
