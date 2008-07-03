From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [0/2] Jack reporting
Date: Thu, 3 Jul 2008 10:50:27 +0100
Message-ID: <20080703095026.GA652@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Dmitry Torokhov <dtor@insightbb.com>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This is a repost of the the jack reporting API I posted recently.  There
are no chances since the last submission - as discussed in that thread
the existing users and the need to support buttons implemented in jacks
pushes me towards use of an input device to represent jacks.
