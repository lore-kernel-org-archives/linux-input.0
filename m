From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: core: Add component pin control functions" to the asoc tree
Date: Wed, 30 Nov 2016 17:16:25 +0000
Message-ID: <E1cC8Ub-0005st-Dk@debutante>
References: <1480434282-26389-2-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:34944 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758182AbcK3RQn (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 30 Nov 2016 12:16:43 -0500
In-Reply-To: <1480434282-26389-2-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, cw00.choi@samsung.com, dmitry.torokhov@gmail.com, myungjoo.ham@samsung.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

The patch

   ASoC: core: Add component pin control functions

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 1b4d9c22191583ef1fb7433417b2ceb2a608d887 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Tue, 29 Nov 2016 15:44:38 +0000
Subject: [PATCH] ASoC: core: Add component pin control functions

It's often the case that a codec driver will need to control its
own pins. However, if a name_prefix has been applied to this codec it
must be included in the name passed to any of the snd_soc_dapm_x_pin()
functions.

The behaviour of the existing pin control functions is reasonable, since
you may want to search for a fully-specified name within the scope of an
entire card. This means that we can't apply the prefix in these functions
because it will break card-scope searches.

Constructing a prefixed string "manually" in codec drivers leads to a lot
of repetition of the same code.

To make this tidier in codec drivers this patch adds a new set of
equivalent functions that take a struct snd_soc_component instead of a
dapm context and automatically add the component's name_prefix to the
given name. This makes it a simple change in codec drivers to be
prefix-safe.

The new functions are not quite trivial enough to be inlines and the
compiler won't be able to compile-away any part of them.

Although it looks somewhat inefficient to have to allocate a temporary
buffer and combine strings, the current design of the widget list
doesn't lend itself to a more optimized implementation - it's a single
list of all widgets on a card and is searched linearly for a matching
string. As pin state changes are generally low-frequency events it's
unlikely to be a significant issue - at least not enough to rewrite the
widget list handling just for this.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h   |  20 +++++
 sound/soc/soc-utils.c | 199 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 219 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4f1c784e44f6..a26c651cb1ee 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1697,4 +1697,24 @@ static inline void snd_soc_dapm_mutex_unlock(struct snd_soc_dapm_context *dapm)
 	mutex_unlock(&dapm->card->dapm_mutex);
 }
 
+int snd_soc_component_enable_pin(struct snd_soc_component *component,
+				 const char *pin);
+int snd_soc_component_enable_pin_unlocked(struct snd_soc_component *component,
+					  const char *pin);
+int snd_soc_component_disable_pin(struct snd_soc_component *component,
+				  const char *pin);
+int snd_soc_component_disable_pin_unlocked(struct snd_soc_component *component,
+					   const char *pin);
+int snd_soc_component_nc_pin(struct snd_soc_component *component,
+			     const char *pin);
+int snd_soc_component_nc_pin_unlocked(struct snd_soc_component *component,
+				      const char *pin);
+int snd_soc_component_get_pin_status(struct snd_soc_component *component,
+				     const char *pin);
+int snd_soc_component_force_enable_pin(struct snd_soc_component *component,
+				       const char *pin);
+int snd_soc_component_force_enable_pin_unlocked(
+					struct snd_soc_component *component,
+					const char *pin);
+
 #endif
diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index 393e8f0fe2cc..644d9a9ebfbc 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -58,6 +58,205 @@ int snd_soc_params_to_bclk(struct snd_pcm_hw_params *params)
 }
 EXPORT_SYMBOL_GPL(snd_soc_params_to_bclk);
 
+int snd_soc_component_enable_pin(struct snd_soc_component *component,
+				 const char *pin)
+{
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(component);
+	char *full_name;
+	int ret;
+
+	if (!component->name_prefix)
+		return snd_soc_dapm_enable_pin(dapm, pin);
+
+	full_name = kasprintf(GFP_KERNEL, "%s %s", component->name_prefix, pin);
+	if (!full_name)
+		return -ENOMEM;
+
+	ret = snd_soc_dapm_enable_pin(dapm, full_name);
+	kfree(full_name);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_enable_pin);
+
+int snd_soc_component_enable_pin_unlocked(struct snd_soc_component *component,
+					  const char *pin)
+{
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(component);
+	char *full_name;
+	int ret;
+
+	if (!component->name_prefix)
+		return snd_soc_dapm_enable_pin_unlocked(dapm, pin);
+
+	full_name = kasprintf(GFP_KERNEL, "%s %s", component->name_prefix, pin);
+	if (!full_name)
+		return -ENOMEM;
+
+	ret = snd_soc_dapm_enable_pin_unlocked(dapm, full_name);
+	kfree(full_name);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_enable_pin_unlocked);
+
+int snd_soc_component_disable_pin(struct snd_soc_component *component,
+				  const char *pin)
+{
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(component);
+	char *full_name;
+	int ret;
+
+	if (!component->name_prefix)
+		return snd_soc_dapm_disable_pin(dapm, pin);
+
+	full_name = kasprintf(GFP_KERNEL, "%s %s", component->name_prefix, pin);
+	if (!full_name)
+		return -ENOMEM;
+
+	ret = snd_soc_dapm_disable_pin(dapm, full_name);
+	kfree(full_name);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_disable_pin);
+
+int snd_soc_component_disable_pin_unlocked(struct snd_soc_component *component,
+					   const char *pin)
+{
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(component);
+	char *full_name;
+	int ret;
+
+	if (!component->name_prefix)
+		return snd_soc_dapm_disable_pin_unlocked(dapm, pin);
+
+	full_name = kasprintf(GFP_KERNEL, "%s %s", component->name_prefix, pin);
+	if (!full_name)
+		return -ENOMEM;
+
+	ret = snd_soc_dapm_disable_pin_unlocked(dapm, full_name);
+	kfree(full_name);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_disable_pin_unlocked);
+
+int snd_soc_component_nc_pin(struct snd_soc_component *component,
+			     const char *pin)
+{
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(component);
+	char *full_name;
+	int ret;
+
+	if (!component->name_prefix)
+		return snd_soc_dapm_nc_pin(dapm, pin);
+
+	full_name = kasprintf(GFP_KERNEL, "%s %s", component->name_prefix, pin);
+	if (!full_name)
+		return -ENOMEM;
+
+	ret = snd_soc_dapm_nc_pin(dapm, full_name);
+	kfree(full_name);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_nc_pin);
+
+int snd_soc_component_nc_pin_unlocked(struct snd_soc_component *component,
+				      const char *pin)
+{
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(component);
+	char *full_name;
+	int ret;
+
+	if (!component->name_prefix)
+		return snd_soc_dapm_nc_pin_unlocked(dapm, pin);
+
+	full_name = kasprintf(GFP_KERNEL, "%s %s", component->name_prefix, pin);
+	if (!full_name)
+		return -ENOMEM;
+
+	ret = snd_soc_dapm_nc_pin_unlocked(dapm, full_name);
+	kfree(full_name);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_nc_pin_unlocked);
+
+int snd_soc_component_get_pin_status(struct snd_soc_component *component,
+				     const char *pin)
+{
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(component);
+	char *full_name;
+	int ret;
+
+	if (!component->name_prefix)
+		return snd_soc_dapm_get_pin_status(dapm, pin);
+
+	full_name = kasprintf(GFP_KERNEL, "%s %s", component->name_prefix, pin);
+	if (!full_name)
+		return -ENOMEM;
+
+	ret = snd_soc_dapm_get_pin_status(dapm, full_name);
+	kfree(full_name);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_get_pin_status);
+
+int snd_soc_component_force_enable_pin(struct snd_soc_component *component,
+				       const char *pin)
+{
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(component);
+	char *full_name;
+	int ret;
+
+	if (!component->name_prefix)
+		return snd_soc_dapm_force_enable_pin(dapm, pin);
+
+	full_name = kasprintf(GFP_KERNEL, "%s %s", component->name_prefix, pin);
+	if (!full_name)
+		return -ENOMEM;
+
+	ret = snd_soc_dapm_force_enable_pin(dapm, full_name);
+	kfree(full_name);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_force_enable_pin);
+
+int snd_soc_component_force_enable_pin_unlocked(
+					struct snd_soc_component *component,
+					const char *pin)
+{
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(component);
+	char *full_name;
+	int ret;
+
+	if (!component->name_prefix)
+		return snd_soc_dapm_force_enable_pin_unlocked(dapm, pin);
+
+	full_name = kasprintf(GFP_KERNEL, "%s %s", component->name_prefix, pin);
+	if (!full_name)
+		return -ENOMEM;
+
+	ret = snd_soc_dapm_force_enable_pin_unlocked(dapm, full_name);
+	kfree(full_name);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_component_force_enable_pin_unlocked);
+
 static const struct snd_pcm_hardware dummy_dma_hardware = {
 	/* Random values to keep userspace happy when checking constraints */
 	.info			= SNDRV_PCM_INFO_INTERLEAVED |
-- 
2.10.2

