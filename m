From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Jack reporting v2
Date: Tue, 3 Jun 2008 11:40:48 +0100
Message-ID: <20080603104048.GA17007@rakim.wolfsonmicro.main>
References: <1212095345928-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1212095345928-git-send-email-broonie@opensource.wolfsonmicro.com>
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

The following couple of patches update the jack reporting API I posted
last week with the feedback I have received so far.  The changes since
the last submision are:

 - Addition of snd_jack_set_parent(), allowing drivers to override the
   default parent for the input device prior to registration.
 - The jack detection support is now included unconditionally in ALSA,
   requiring a dependency on the input subsystem.

I'm not entirely happy with making ALSA depend on input but given that
it is only optional on embedded systems and that the input core is not
that large it seemed the best way of ensuring that the input subsystem
is available for the jack API without hassle for drivers using it,
especially given the lack of dependency propagation from select.
