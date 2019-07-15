From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH 8/8] docs: remove extra conf.py files
Date: Mon, 15 Jul 2019 04:57:02 -0300
Message-ID: <20190715045702.1e2b569b@coco.lan>
References: <cover.1563115732.git.mchehab+samsung@kernel.org>
        <12a160afc9e70156f671010bd4ccff9311acdc5e.1563115732.git.mchehab+samsung@kernel.org>
        <e3ff0a8a-6956-3855-07be-9c126df2da2d@darmarit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <e3ff0a8a-6956-3855-07be-9c126df2da2d@darmarit.de>
Sender: netdev-owner@vger.kernel.org
To: Markus Heiser <markus.heiser@darmarit.de>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-input@vger.kernel.org

Em Mon, 15 Jul 2019 08:16:54 +0200
Markus Heiser <markus.heiser@darmarit.de> escreveu:

> Hi Mauro,
> 
> sorry, I havn't tested your patch, but one question ...
> 
> Am 14.07.19 um 17:10 schrieb Mauro Carvalho Chehab:
> > Now that the latex_documents are handled automatically, we can
> > remove those extra conf.py files.  
> 
> We need these conf.py also for compiling books' into HTML.  For this
> the tags.add("subproject") is needed.  Should we realy drop this feature?
> 
> -- Markus --

You're right: adding "subproject" tags is needed for html. Folding this
to patch 7/8 makes both htmldocs and pdfdocs to work with SPHINXDIRS
without the need of a per-subdir conf.py.

Regards,
Mauro

diff --git a/Documentation/sphinx/load_config.py b/Documentation/sphinx/load_config.py
index 75f527ff4c95..e4a04f367b41 100644
--- a/Documentation/sphinx/load_config.py
+++ b/Documentation/sphinx/load_config.py
@@ -51,3 +51,7 @@ def loadConfig(namespace):
             execfile_(config_file, config)
             del config['__file__']
             namespace.update(config)
+        else:
+            config = namespace.copy()
+            config['tags'].add("subproject")
+            namespace.update(config)

Thanks,
Mauro
