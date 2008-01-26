From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [UPDATED v4] WM97xx touchscreen drivers
Date: Sat, 26 Jan 2008 15:18:20 +0000
Message-ID: <20080126151820.GA13899@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752900AbYAZPSp@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, Liam Girdwood <liam.girdwood@wolfsonmicro.com>, Rodolfo Giometti <giometti@enneenne>
List-Id: linux-input@vger.kernel.org

This patch series adds support for the touchscreen controllers provided
by Wolfson Microelectronics WM97xx series chips in both polled and
streaming modes.

Changes since last submission:
 - Fix from Dmitry Baryshkov for build with CONFIG_PM.
 - Add the web site to the MAINTAINERS entry.
